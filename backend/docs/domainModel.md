# ドメインモデル図

## 集約一覧

| 集約 | 概要 |
|------|------|
| [Shop](domains/shop.md) | 珈琲豆を提供する店舗 |
| [CoffeeBean](domains/coffeeBean.md) | 店舗が提供する珈琲豆 |
| [Taste](domains/taste.md) | テイスト評価の種別（酸味・苦味など） |
| [CoffeeListGroup](domains/coffeeListGroup.md) | CSサイトに表示する珈琲豆リスト |

## ドメインモデル図

```mermaid
classDiagram
  namespace Shop集約 {
    class Shop {
      <<Aggregate Root>>
      id: ShopId
      name: String
      introduction: String?
      particular: String?
      images: List~ShopImage~
    }

    class ShopImage {
      <<Entity>>
      id: ShopImageId
      type: ShopImageType
      imageUrl: ImageUrl
    }

    class ShopImageType {
      <<Enum>>
      main
    }
  }

  Shop *-- ShopImage
  ShopImage --> ShopImageType

  namespace CoffeeBean集約 {
    class CoffeeBean {
      <<Aggregate Root>>
      id: CoffeeBeanId
      shopId: ShopId
      name: String
      description: String
      origin: String
      farm: String?
      roastLevel: RoastLevel
      processingMethod: ProcessingMethod
      images: List~CoffeeBeanImage~
      tastes: List~CoffeeBeanTaste~
    }

    class CoffeeBeanImage {
      <<Entity>>
      id: CoffeeBeanImageId
      type: CoffeeBeanImageType
      imageUrl: ImageUrl
    }

    class CoffeeBeanImageType {
      <<Enum>>
      main
    }

    class CoffeeBeanTaste {
      <<Entity>>
      id: CoffeeBeanTasteId
      tasteId: TasteId
      evaluationValue: Int
    }

    class RoastLevel {
      <<Enum>>
      light
      medium
      city
      french
    }

    class ProcessingMethod {
      <<Enum>>
      fully_washed
      washed
      thermal_shock_natural
      natural
      wet_hulling
      honey
    }
  }

  CoffeeBean --> RoastLevel
  CoffeeBean --> ProcessingMethod
  CoffeeBean o-- Shop : shopId
  CoffeeBeanImage --> CoffeeBeanImageType
  CoffeeBean *-- CoffeeBeanImage
  CoffeeBean *-- CoffeeBeanTaste

  namespace Taste集約 {
    class Taste {
      <<Aggregate Root>>
      id: TasteId
      name: String
    }
  }

  CoffeeBeanTaste o-- Taste : tasteId

  namespace CoffeeListGroup集約 {
    class CoffeeListGroup {
      <<Aggregate Root>>
      id: CoffeeListGroupId
      description: String?
      children: List~CoffeeListChild~
    }

    class CoffeeListChild {
      <<Entity>>
      id: CoffeeListChildId
      coffeeBeanId: CoffeeBeanId
    }
  }

  CoffeeListGroup *-- CoffeeListChild
  CoffeeListChild o-- CoffeeBean : coffeeBeanId
```

## 凡例

| 記号 | 意味 |
|------|------|
| `<<Aggregate Root>>` | 集約ルート。トランザクション整合性の境界 |
| `<<Entity>>` | 集約内のエンティティ。集約ルート経由でのみアクセス |
| `<<Value Object>>` | 値オブジェクト。不変で同値性で比較 |
| `<<Enum>>` | 列挙型。取りうる値が固定された値オブジェクト |
| `*--` (塗りつぶし菱形) | コンポジション。親が子のライフサイクルを管理 |
| `o--` (白抜き菱形) | ID参照。他の集約をIDで参照（直接保持しない） |
| `-->` | 依存。値オブジェクトの利用など |
