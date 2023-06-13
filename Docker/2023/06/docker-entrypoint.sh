#! /bin/sh
# 输出日志
JAVA_SERVER_OUT='/app/logs/server.out'
echo "JAVA_SERVER_OUT = $JAVA_SERVER_OUT"

echo "java -server -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:+UseWisp2 -Dloader.path=/app/lib -Dfile.encoding=UTF-8 -jar /app/bin/app.jar --logging.file.path=/app/logs --server.port=8080"
nohup java -server -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:+UseWisp2 -Dloader.path=/app/lib -Dfile.encoding=UTF-8 -jar /app/bin/app.jar --logging.file.path=/app/logs --server.port=8080 >> $JAVA_SERVER_OUT 2>&1 &
tail -f $JAVA_SERVER_OUT
