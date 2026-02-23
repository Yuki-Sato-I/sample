# ユースケース図

## 顧客側ユースケース

```mermaid
graph LR
  Customer(("顧客"))

  subgraph CSサイト
    UC_CS_BeanList["今月の選べる珈琲豆の<br>一覧を閲覧する"]
    UC_CS_BeanDetail["珈琲豆の詳細を確認する"]
    UC_CS_ShopDetail["珈琲豆を提供している<br>店舗情報を閲覧する"]
  end

  Customer --> UC_CS_BeanList
  Customer --> UC_CS_BeanDetail
  Customer --> UC_CS_ShopDetail
```

## ユースケース一覧

| # | ユースケース |
|---|------------|
| CS-1 | 今月の選べる珈琲豆の一覧を閲覧する |
| CS-2 | 珈琲豆の詳細を確認する |
| CS-3 | 珈琲豆を提供している店舗情報を閲覧する |

## 凡例

| 記号 | 意味 |
|------|------|
| `(("名前"))` | アクター |
| `["名前"]` | ユースケース |
| `subgraph` | システム境界 |
| `-->` | アクターがユースケースを実行する |
