# RecipeBook

📚🍕The IOS application for watching recipes, created with the Spoonacular API.

RecipeBook allows users to search for any recipes they want using pretty yet handy filters. For example, users can set filters to show only vegetarian and gluten-free food. They can also see the nutritional information for almost every recipe!

That's my first application where I've built the User Interface with the UIKit programmatically completely without a storyboard. Also, I've used Auto Layout Constraints for that.

## Preview

![](https://github.com/SenKill/RecipeBook/blob/0ba637510c20b6f98273a55e8ff302834de5572c/GifsAndPictures/Preview.gif)
![](https://github.com/SenKill/RecipeBook/blob/5514b62d27557e6c8563c17f7c05df26f5c27308/GifsAndPictures/DarkPreview.gif)

## Features

### Already implemented:

- Favorites
- Search with filters

![](https://github.com/SenKill/RecipeBook/blob/0ba637510c20b6f98273a55e8ff302834de5572c/GifsAndPictures/Filters.gif)

- Tags
- Nutrition info
- Ingredients

![](https://github.com/SenKill/RecipeBook/blob/0ba637510c20b6f98273a55e8ff302834de5572c/GifsAndPictures/Ingredients.gif)

- Preparation info or Link button to the source

### Future features

- Meal planning

## Technologies and Instruments

- UIKit
- MVC design pattern
- Programmatic approach
- Auto Layout constraints
- UserDefaults
- [TagListView framework](https://github.com/ElaWorkshop/TagListView)
- [Spoonacular API](https://spoonacular.com/food-api)

### MVC pattern:
I've learned about that approach from this [Article](https://medium.com/@omaralbeik/making-mvc-great-again-829ef9461ec2).

In this project, to properly use the MVC design pattern with the programmatic approach for UIKit, I've used Generics and created subclasses for UIView...

```swift
// MARK: - CustomView
class CView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        layoutViews()
    }
    
    func setViews() {
        backgroundColor = UIColor.theme.background
        // Add subviews and configure them here
    }
    
    func layoutViews() {
        // Write constraints here
    }
}

```

**And UIViewController:**

```swift
// MARK: - CustomViewController
class CViewController<V: CView>: UIViewController {

    override func loadView() {
        view = V()
    }

    // To access view use this computed property
    var customView: V {
        view as! V
    }
}
```

Just subclass these classes if you want to create a new ViewController.
If you want to see the practical use of this approach, you can open my files in this repository or open the links below:

[HomeView.swift](https://github.com/SenKill/RecipeBook/blob/90df40945993665724828cdee6f37d895218ec28/RecipeBook/Sources/ViewsAndControllers/Home/HomeView.swift)

[HomeViewController.swift](https://github.com/SenKill/RecipeBook/blob/90df40945993665724828cdee6f37d895218ec28/RecipeBook/Sources/ViewsAndControllers/Home/HomeViewController.swift)
