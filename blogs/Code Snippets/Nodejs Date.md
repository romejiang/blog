# Node日期相关的

```jsx
// console.log('昨天' , (addDate(-1)+' 00:00:00') , addDate(-1)+' 23:59:59')
// console.log('今天' , (addDate(0)+' 00:00:00') , addDate(0)+' 23:59:59')
// console.log('当周' , (addDate(-new Date().getDay()+1)+' 00:00:00') , addDate(7-new Date().getDay())+' 23:59:59')
// console.log('当月' , (addDate(-new Date().getDate()+1)+' 00:00:00') , addDate(getDayOfMonth()-new Date().getDate())+' 23:59:59')

// addDate(-1) 减一天
// addDate(0) 今天
// addDate(-new Date().getDay()+1) 本周第一天
// addDate(-new Date().getDate()+1) 本月第一天
//加减天数(含时分秒)
exports.addDate = function (days, type, position = 'start') {
  var d = new Date()
  d.setDate(d.getDate() + days)
  var month = d.getMonth() + 1
  var day = d.getDate()
  var hour = d.getHours()
  var minutes = d.getMinutes()
  var seconds = d.getSeconds()
  if (month < 10) {
    month = '0' + month
  }
  if (day < 10) {
    day = '0' + day
  }
  var time = ''
  //type不是空字符串 表示需要时分秒
  if (type != null && '' != type) {
    if (hour < 10) {
      hour = '0' + hour
    }
    if (minutes < 10) {
      minutes = '0' + minutes
    }
    if (seconds < 10) {
      seconds = '0' + seconds
    }
    time = ' ' + hour + ':' + minutes + ':' + seconds
  }
  var val = d.getFullYear() + '-' + month + '-' + day + time
  return val + (position === 'start' ? ' 00:00:00' : position === 'last' ? ' 23:59:59' : '')
}

// 获取当前月份的总天数 ， 29/30/31
exports.getDayOfMonth = function () {
  var date = new Date()
  var year = date.getFullYear()
  var month = date.getMonth() + 1
  var d = new Date(year, month, 0)
  return d.getDate()
}
```