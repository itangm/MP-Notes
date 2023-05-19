# Vue API风格

`Vue`的组件可以按两种不同的风格书写：**选项式API**和**组合式API**。选项式API认为就是`Vue2`的语法风格，而组合式API是`Vue3`的语法风格。

## 选项式API（Options API）

使用选项式API，我们可以用包含多个选项的对象来描述组件的逻辑，例如`data`、`methods`和`mounted`。选项所定义的属性都会暴露在函数内部的`this`上，它会指向当前的组件实例。

```vue
<script>
export default() {
    data() {
        return {
            count: 0
        }
    },
    methods: {
        increment() {
            this.count ++
        }
    },
    mounted() {
        console.log("count = ${this.count}")
    }
}
</script>

<template>
    <button @click="increment">Count is : {{ count }}</button>
</template>
```

## 组合式API（Composition API）

通过组合式API，我们可以使用导入的API函数来描述组件逻辑。

```vue
<script setup>
import {ref, onMounted} from 'vue'
const count = ref(0)
function increment() {
    count.value ++
}
onMounted(() => {
    console.log("count = ${count.value}")
})
</script>
<template>
    <button @click="increment">Count is : {{ count }}</button>
</template>
```

## 用哪个了？

两种API风格都能覆盖大部分的应用场景，它们只是同一个底层系统所提供的两套不同的接口。实际上，选项式API是在组合式API的基础上实现的、

在实际生产项目中

* 当你不需要使用构建工具，或者打算主要在低复杂度的场景中使用`Vue`，例如渐进增强的应用场景，推荐采用选项式API。
* 当你打算用`Vue`构建完整的单页面应用，推荐使用组合式API+单文件组件。
