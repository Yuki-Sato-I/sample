# GET /api/coffee-list-groups/{coffeeListGroupId}

## 概要

指定された珈琲リストグループの詳細を取得する。リストに含まれる珈琲豆の情報（画像・テイスト評価含む）を返す。

## リクエスト

| 項目 | 値 |
|------|---|
| メソッド | GET |
| パス | `/api/coffee-list-groups/{coffeeListGroupId}` |
| パスパラメータ | `coffeeListGroupId` (String) - 珈琲リストグループID |

## レスポンス

### 200 OK

```json
{
  "id": "01JCLGR0000000000000000001",
  "description": "2026年2月のおすすめ珈琲豆",
  "coffeeBeans": [
    {
      "id": "01JBEAN0000000000000000001",
      "name": "エチオピア イルガチェフェ G1",
      "description": "花のような華やかなフレーバーと、柑橘系の明るい酸味が特徴。",
      "origin": "エチオピア",
      "farm": "イルガチェフェ コチャレ地区",
      "roastLevel": "light",
      "processingMethod": "washed",
      "images": [
        {
          "type": "main",
          "imageUrl": "https://placehold.jp/150x150.png"
        }
      ],
      "tastes": [
        {
          "tasteName": "酸味",
          "evaluationValue": 5
        },
        {
          "tasteName": "苦味",
          "evaluationValue": 1
        }
      ]
    }
  ]
}
```

### 404 Not Found

指定された `coffeeListGroupId` に該当するリストが存在しない場合。

```json
{
  "timestamp": "2026-02-23T12:00:00.000+00:00",
  "status": 404,
  "error": "Not Found",
  "path": "/api/coffee-list-groups/01JCLGR0000000000000000099"
}
```

## 取得するデータの範囲

CoffeeListGroupを起点に、以下を結合して取得する：

| テーブル | 結合条件 | 取得項目 |
|---------|---------|---------|
| `coffee_list_groups` | 起点 | id, description |
| `coffee_list_childs` | coffee_list_group_id | - (結合用) |
| `coffee_beans` | coffee_list_childs.coffee_bean_id | id, name, description, origin, farm, roast_level, processing_method |
| `coffee_bean_images` | coffee_beans.id | type, image_url |
| `coffee_bean_tastes` | coffee_beans.id | evaluation_value |
| `tastes` | coffee_bean_tastes.tastes_id | name |
