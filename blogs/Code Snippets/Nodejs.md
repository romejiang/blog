+++
date = 2017-03-12
title = 'nodejs 一些常用的 snippets'
categories = ['coding']
tags = [
    "coding",
    "nodejs",
]
+++



## 遍历 times 

```js 

Array(10).fill().map((_, i) => i + 1)

Array.from(Array(10), (_, i) => i)

// 用户callback实现
const times = x => f => {
  if (x > 0) {
    f()
    times (x - 1) (f)
  }
}

// use it
times (3) (() => console.log('hi'))

// or define intermediate functions for reuse
let twice = times (2)

// twice the power !
twice (() => console.log('double vision'))
```

## 数组去重
```js
// 使用 set
const arr = ['justin1go', 'justin2go', 'justin2go', 'justin3go', 'justin3go', 'justin3go'];
const uniqueArr = Array.from(new Set(arr));

// 使用 filter
const arr = ['justin1go', 'justin2go', 'justin2go', 'justin3go', 'justin3go', 'justin3go'];
const uniqueArr = arr.filter((item, index) => {
	return arr.indexOf(item, 0) === index;
})

```

## sort()的回调函数

```js
// 数字升序：
arr.sort((a,b)=>a-b)
// 按字母顺序对字符串数组进行排序：
arr.sort((a, b) => a.localeCompare(b))
// 根据真假值进行排序：
const users = [
  { "name": "john", "subscribed": false },
  { "name": "jane", "subscribed": true },
  { "name": "jean", "subscribed": false },
  { "name": "george", "subscribed": true },
  { "name": "jelly", "subscribed": true },
  { "name": "john", "subscribed": false }
];

const subscribedUsersFirst = users.sort((a, b) => Number(b.subscribed) - Number(a.subscribed))

```

## 短路操作

或操作a || b：该操作只要有一个条件为真值时，整个表达式就为真；即a为真时，b不执行；
且操作a && b：该操作只要有一个条件为假值时，整个表达式就为假；即a为假时，b不执行；

```js
// 设置默认值
const price = query.price || 0

// 检查空变量
function fn(callback) {
	callback && callback()
}
// 基于默认值的对象赋值
function fn(setupData) {
	const defaultSetup = {
		email: "justin3go@qq.com",
		userId: "justin3go",
		skill: "code",
		work: "student"
	}
	return { ...defaultSetup, ...setupData }
}

const testSetData = { skill: "sing" }
console.log(fn(testSetData))


```
## 异步流下载

```js
exports.download = async function (url, dist) {
  // return new Promise((resolve,reject)=>{
  //   request.get(options).on('end', function (err) {
  //     resolve()
  //   }).pipe(fs.createWriteStream(dist))
  // })
  return await this.ctx.curl(url, { method: 'GET', writeStream: require('fs').createWriteStream(dist) })
}
```

## 支持 import 的导出
```js
export default () => {
  console.log('Hi from the default export!');
};

// OR

export default user;

export { success, fail }

exports.download = async function (url, dist)

module.exports = {
  getSearch
}

```

## 动态 import

```js

const moduleSpecifier = './utils.mjs';
import(moduleSpecifier)
  .then((module) => {
    module.default();
    // → logs 'Hi from the default export!'
    module.doStuff();
    // → logs 'Doing stuff…'
  });


(async () => {
  const moduleSpecifier = './utils.mjs';
  const module = await import(moduleSpecifier)
  module.default();
  // → logs 'Hi from the default export!'
  module.doStuff();
  // → logs 'Doing stuff…'
})();
```