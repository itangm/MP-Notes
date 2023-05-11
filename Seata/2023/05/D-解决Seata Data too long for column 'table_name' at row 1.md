# 解决Seata Data too long for column 'table_name' at row 1

## 问题描述

```log
2023-05-11 17:11:21.088 ERROR 7 --- [nio-8080-exec-4] i.s.r.d.exec.AbstractDMLBaseExecutor     : execute executeAutoCommitTrue error:io.seata.core.exception.RmTransactionException: Response[ TransactionException[branch register request failed. xid=192.168.10.67:8091:72427642740343598, msg=Data truncation: Data too long for column 'table_name' at row 1] ]

java.sql.SQLException: io.seata.core.exception.RmTransactionException: Response[ TransactionException[branch register request failed. xid=192.168.10.67:8091:72427642740343598, msg=Data truncation: Data too long for column 'table_name' at row 1] ]
        at io.seata.rm.datasource.ConnectionProxy.recognizeLockKeyConflictException(ConnectionProxy.java:161) ~[seata-all-1.6.1.jar!/:1.6.1]
        at io.seata.rm.datasource.ConnectionProxy.processGlobalTransactionCommit(ConnectionProxy.java:252) ~[seata-all-1.6.1.jar!/:1.6.1]
        at io.seata.rm.datasource.ConnectionProxy.doCommit(ConnectionProxy.java:230) ~[seata-all-1.6.1.jar!/:1.6.1]
        at io.seata.rm.datasource.ConnectionProxy.lambda$commit$0(ConnectionProxy.java:188) ~[seata-all-1.6.1.jar!/:1.6.1]
        at io.seata.rm.datasource.ConnectionProxy$LockRetryPolicy.execute(ConnectionProxy.java:344) ~[seata-all-1.6.1.jar!/:1.6.1]
        at io.seata.rm.datasource.ConnectionProxy.commit(ConnectionProxy.java:187) ~[seata-all-1.6.1.jar!/:1.6.1]
        at io.seata.rm.datasource.exec.AbstractDMLBaseExecutor.lambda$executeAutoCommitTrue$2(AbstractDMLBaseExecutor.java:138) [seata-all-1.6.1.jar!/:1.6.1]
        at io.seata.rm.datasource.ConnectionProxy$LockRetryPolicy.doRetryOnLockConflict(ConnectionProxy.java:356) ~[seata-all-1.6.1.jar!/:1.6.1]
        at io.seata.rm.datasource.exec.AbstractDMLBaseExecutor$LockRetryPolicy.execute(AbstractDMLBaseExecutor.java:180) ~[seata-all-1.6.1.jar!/:1.6.1]
        at io.seata.rm.datasource.exec.AbstractDMLBaseExecutor.executeAutoCommitTrue(AbstractDMLBaseExecutor.java:136) [seata-all-1.6.1.jar!/:1.6.1]
        at io.seata.rm.datasource.exec.AbstractDMLBaseExecutor.doExecute(AbstractDMLBaseExecutor.java:82) [seata-all-1.6.1.jar!/:1.6.1]
        at io.seata.rm.datasource.exec.BaseTransactionalExecutor.execute(BaseTransactionalExecutor.java:125) [seata-all-1.6.1.jar!/:1.6.1]
        at io.seata.rm.datasource.exec.ExecuteTemplate.execute(ExecuteTemplate.java:137) [seata-all-1.6.1.jar!/:1.6.1]
        at io.seata.rm.datasource.exec.ExecuteTemplate.execute(ExecuteTemplate.java:56) [seata-all-1.6.1.jar!/:1.6.1]
        at io.seata.rm.datasource.PreparedStatementProxy.execute(PreparedStatementProxy.java:55) [seata-all-1.6.1.jar!/:1.6.1]
        at sun.reflect.GeneratedMethodAccessor301.invoke(Unknown Source) ~[na:na]
```

## 问题寻找

出现这个问题后，原因在于存储数据超出字段长度限制，立马就会看`undo_log`表的结构，发现并没有`'table_name'`列，然后一下子就怀疑这个是从哪里来的呢？后来想到`seata-server`本身有一个数据库，猜测问题应该出现在那里。

## 问题解决

打开`seata-server`，通过查看表结构，最终确定`lock_table`表存在列名`'table_name'`，发现字段长度为`32`，将其修改为`64`之后问题立马解决。下面是修改后的表结构

```sql
CREATE TABLE `lock_table` (
  `row_key` varchar(128) NOT NULL,
  `xid` varchar(128) DEFAULT NULL,
  `transaction_id` bigint DEFAULT NULL,
  `branch_id` bigint NOT NULL,
  `resource_id` varchar(256) DEFAULT NULL,
  `table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `pk` varchar(36) DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0:locked ,1:rollbacking',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`row_key`),
  KEY `idx_status` (`status`),
  KEY `idx_branch_id` (`branch_id`),
  KEY `idx_xid` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```
