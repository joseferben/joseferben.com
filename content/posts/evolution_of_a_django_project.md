+++
title = "The evolution of a Django project"
author = ["Josef Erben"]
date = 2021-12-25
tags = ["django", "python"]
draft = true
+++

-   <https://www.reddit.com/r/rails/comments/ssbps0/no_silver_buckets/>

Most of the Django style guides I have seen give solid advice on how to structure Django projects. However, very few consider the evolution of the project structure over time. In this post I document my current approach.

<!--more-->


## The Standard Django App {#the-standard-django-app}

Let's start with a project that consists of a default Django app called `main`.

```nil
├── admin.py
├── apps.py
├── __init__.py
├── migrations
│   └── __init__.py
├── models.py
├── tests.py
└── views.py
```

Django follows the models-templates-views (MTV) model. The business logic lives in `models.py` and `views.py` contains logic that handles infrastructure concerns such as HTTP, forms, permissions but also presentation logic.


## Growing The Main App {#growing-the-main-app}

After a while, it becomes very tempting to add new apps. Maybe we think that we found a component that looks like it could stand on its own. Or maybe we have some other project where this app could be re-used.

The truth is often, that we don't know what we don't know. Resist the urge to create new apps and keep growing the `main` app. Moving models between apps later on is quite costly. At some point, it is absolutely desirable to have multiple apps in a project. Try to delay that until you don't touch the fields of the models anymore and you have a pretty good idea which model _know_ which other model.

More importantly, the dependencies between _groups_ of models should become clear with time.


### Evolving Models {#evolving-models}


#### Reading Data {#reading-data}

-   property, query, model manager


#### Mutating Data {#mutating-data}

instance method, static method, namespace classes


#### File system {#file-system}

```nil
├── models
│   ├── __init__.py
│   ├── domain_a.py
│   ├── domain_b.py
│   └── domain_c.py
```

`__init__.py`

```python
from .domain_a import *
from .domain_b import *
from .domain_c import *
```


### Evolving Views {#evolving-views}

```nil
  └── views
      ├── __init__.py
    ├── views.py
    ├── mixins.py
    └── screens.py
```


### Other Business Logic {#other-business-logic}

-   multiple models involved, complex logic, some people call it service layer, but has nothing to do with swapping implementations
-   services and async tasks.py


## Towards Multiple Apps {#towards-multiple-apps}

It is time to break up the `main` app and consider which parts can be extracted as separate apps.

[some people say one app can do, but apps can further decouple and package components and we can make use of them]


### Identification {#identification}

Steps to identify apps.

1.  Consider _knowing_ and _doing_ of every model. What does a model class do and who else does it know?
2.  ...


### Extraction {#extraction}


### Decoupling {#decoupling}

-   signals
-   receivers


## Decisions, decisions, decisions {#decisions-decisions-decisions}

[post directory structure, and summarize established architecture]
[add decision chart of where to put logic]


## No Silver Bullet {#no-silver-bullet}

-   no one size fits all solution, your mileage may vary, schablone could help you do thi