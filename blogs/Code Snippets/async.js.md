# async.js 库的使用

async.js 库分为两大类方法，Collections 和 Control Flow。在整个async语境里 series 代表串行执行。Limit 代表并行执行中控制并行数量。

http://caolan.github.io/async/v3/index.html

### Collections 主要处理数组，方法比较多

  async.each 遍历数组，无返回值
  async.map 遍历数组，有返回值，返回值和传入的数组顺序一致
  async.filter 遍历数组，有返回值，过滤之返回符合要求的数组处理结果
  async.reduce 遍历数组，有返回值
  async.detect 遍历数组，有返回值
  async.concat 遍历数组，有返回值，将数组处理结果拼接成一个数组返回
  async.groupBy 遍历数组，有返回值，根据返回值分组



### Control Flow 主要处理一组方法。主要是一下三个

  async.series 串行且无关联，序列
  async.parallel 并行且无关联，并行
  async.waterfall 串行且有关联，瀑布流


一般 async.eachLimit 和 async.mapLimit 就可以解决大部份问题。
因为串行执行不需要使用 async.js 库。完全并行也不需要 Promise.all() 就可以实现。

所以主要用到是并行但控制数量的几个方法，比如： async.eachLimit 和 async.mapLimit
和控制方法并行的方法，比如：async.series， async.parallel， async.waterfall


async.eachLimit 和 async.mapLimit 两个方法类似于多线程解决的问题。比如有1000个文件需要处理，一个一个来太慢，但同时一起处理1000个有会吧cpu资源卡死。最理想的方法是10个10个处理或者20个20个处理。


### 案例

```js

;(async () => {
  // 读取user_data下所有.py文件
  // const rootpath = 'user_data/strategies/'
  const rootpath = 'res001/'
  const files = await fs.promises.readdir(rootpath)
  const pyFiles = files.filter((f) => f.endsWith('.csv'))
  const fullFiles = pyFiles.map((f) => rootpath + f)
  // console.log(csvFiles)
  // for (const file of fullFiles) {
  //   console.log(file)
  // }
  function fileExists(file, callback) {
    setTimeout(() => {
      console.log(file)
      fs.access(file, fs.constants.F_OK, (err) => {
        callback(null, !err)
      })
    }, 1000)
  }
  // const res = await async.concat(fullFiles, fileExists)
  await async.eachLimit(fullFiles, 5, fileExists)
})()


console.time('parallel')
async.parallel(
  {
    one: function (done) {
      //处理逻辑
      console.log('===one')
      done(null, 'one')
    },
    two: function (done) {
      //处理逻辑
      console.log('===two')
      done(null, 'two')
    },
    three: function (done) {
      //处理逻辑
      console.log('===three')
      done(null, 'three')
    },
    four: function (done) {
      //处理逻辑
      console.log('===four')
      done(null, 'four')
    }
  },
  function (error, result) {
    console.log('one:', result.one)
    console.log('two:', result.two)
    console.log('three:', result.three)
    console.log('four:', result.four)
    console.timeEnd('parallel')
  }
)


async.series(
  {
    one: function (done) {
      //处理逻辑
      console.log('===one')
      done(null, 'one')
    },
    two: function (done) {
      //处理逻辑
      console.log('===two')
      done(null, 'two')
    },
    three: function (done) {
      //处理逻辑
      console.log('===three')
      done(null, 'three')
    },
    four: function (done) {
      //处理逻辑
      console.log('===four')
      done(null, 'four')
    }
  },
  function (error, result) {
    console.log('one:', result.one)
    console.log('two:', result.two)
    console.log('three:', result.three)
    console.log('four:', result.four)
    console.timeEnd('series')
  }
)

// ===one
// ===two
// ===three
// ===four
// one: one
// two: two
// three: three
// four: four
// series: 6.716ms


async.waterfall(
  [
    function (done) {
      done(null, 'one')
    },
    function (onearg, done) {
      done(null, onearg + '| two')
    },
    function (twoarg, done) {
      done(null, twoarg + '| three')
    },
    function (threearg, done) {
      done(null, threearg + '| four')
    }
  ],
  function (error, result) {
    console.log(result)
    console.timeEnd('waterfall')
  }
)

```