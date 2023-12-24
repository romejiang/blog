# mongo 相关的

## 聚合查询

```jsx
// 有余额的用户
    const balance_users = await ctx.model.Accounts.aggregate([
      {
        $match: {
          $or: [{ gold: { $gt: 0 } }, { wood: { $gt: 0 } }, { food: { $gt: 0 } }],
        },
      },
      {
        $count: 'count',
      },
    ])
    // 金子总数
    const golds = await ctx.model.Accounts.aggregate([
      {
        $match: {
          gold: { $gt: 0 },
        },
      },
      {
        $group: {
          _id: '$user',
          total: { $sum: '$gold' },
          count: { $sum: 1 },
        },
      },
    ])

```

## 聚合查询 + 分页

```jsx
const weeks = await ctx.model.Bills.aggregate([
      {
        $match: {
          amount: { $gt: 0 },
          createdAt: sort,
        },
      },
      {
        $group: {
          _id: '$user',
          totalAmount: { $sum: '$amount' },
          count: { $sum: 1 },
        },
      },
      {
        $sort: { totalAmount: -1 },
      },
      { $skip: skip },
      { $limit: pageSize },
      {
        $lookup: {
          from: ctx.model.User.collection.name,
          localField: '_id',
          foreignField: '_id',
          as: 'user',
        },
      },
    ])

const countQuery = await ctx.model.Bills.aggregate([
      {
        $match: {
          amount: { $gt: 0 },
          createdAt: sort,
        },
      },
      {
        $group: {
          _id: '$user',
          totalAmount: { $sum: '$amount' },
          count: { $sum: 1 },
        },
      },
      {
        $count: 'myCount',
      },
    ])
```

## 聚合库表查询

```jsx
const aggregate = ctx.model.Lineups.aggregate([
      {
        $lookup: {
          from: ctx.model.Rooms.collection.name,
          localField: 'room',
          foreignField: '_id',
          as: 'rooms',
        },
      },
      {
        $match: {
          'user':  new ObjectId(_id),
          'win': 1 ,
          'rooms.status' : 2
        },
      },
      {
        $sort:{ createdAt: -1 }
      }
    ])

    const res = await aggregate.exec()
```

## 周排行

```jsx
const weeks = await ctx.model.Sender.aggregate([
      {
        $match: {
          sender: new ObjectId(_id ),
        },
      },
      {
        $group: {
          _id: '$sender',
          totalAmount: { $sum: '$amount' },
          count: { $sum: 1 },
        },
      },
      {
        $sort: { totalAmount: -1 },
      },
      { $limit: 10 },
      {
        $lookup: {
          from: ctx.model.User.collection.name,
          localField: '_id',
          foreignField: '_id',
          as: 'sender',
        },
      },
    ])
```

## 查询并保存

```jsx
		let query = { miner: miner, user: user, mac: mac }
    let update = payload,
    let options = { upsert: true, new: true, setDefaultsOnInsert: true };

    return await ctx.model.Disk.findOneAndUpdate(query, update, options).exec()
// 返回的结果
    {
  lastErrorObject: { n: 1, updatedExisting: true },
  value: {
    _id: new ObjectId("6575f51c18ecea1da3faa6a1"),
    username: 'Visitor0365',
    password: '057268a18b85c8e6e273a571416bf736',
    avatar: '/static/avatar.jpg',
    pass: true,
    guest: false,
    createdAt: 1702229276922,
    updatedAt: 1702229276922,
    openid: 'oMDKn5UC0-Jzh5qgnFElDT6MZptE'
  },
  ok: 1
}
```

```jsx

```