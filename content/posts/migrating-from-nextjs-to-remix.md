+++
title = "Migrating from NextJS to Remix"
author = ["Josef Erben"]
date = 2022-07-21
draft = false
+++

I recently migrated a Next.js project to Remix in order to improve performance and maintainability. These are 8 reasons why you should and should not use Remix.

<!--more-->


## tl;dr {#tl-dr}

The migrated Next.js app can be described as follows:

-   10 file based routes
-   50 components
-   Tailwind for styling
-   deployed on Vercel

After the migration to Remix and using Cloudflare Workers as deployment target, following changed:

-   10-15% performance improvement ([Core Web Vitals](https://web.dev/vitals/))
-   5-10% smaller code base

The migration itself was mostly straightforward with minor hiccups around SSR third-party React components.


## The migration {#the-migration}

The Next.js app had a clean separation of pages and components. Each component contained its own style and logic. Some of the logic was extracted using hooks for easier re-use across multiple components.

Both Next.js and Remix are React frameworks with decent support for Tailwind. After setting up the initial structure, migrating the React components was as easy as going through all of their dependencies and replacing every package with a `@next` scope.


### Images {#images}

Next.js provides a solid [&lt;Image&gt;](https://nextjs.org/docs/api-reference/next/image) component that works out of the box. The component does quiet a bit of heavy lifting and I only realized its scope when I had to find a replacement.
Remix does not come with a comparable solution. At the time of writing, there is [remix-image](https://github.com/Josh-McFarlin/remix-image).

```typescript
<Image
  src="https://asset.example.org/image.png"
  responsive={[
    {
      size: { width: 100, height: 100 },
      maxWidth: 500,
    },
    {
      size: { width: 600, height: 600 },
    },
  ]}
  dprVariants={[1, 3]}
/>
```

I decided to use the asset service that was provided by the client to create image renditions (= different sizes of the same image). Using the renditions and setting `srcset` manually, I ended up with a smaller, less powerful custom `<Image>` component.


### Routing {#routing}

Both Remix and Next.js use file based routing. To create a path hierarchy by you need to create files that export React components (and other things).

Both frameworks come with their `<Link>` components to abstract away client side routing and data fetching. Replacing the Next.js version with the Remix version was trivial.

Remix brings nested routes to the table. Strictly speaking, the router of Remix can do everything that the router of Next.js can do. It's possible to keep the routes and the file structure of a Next.js app and just keep using them with Remix.

However, in order to take advantage of proper error propagation and better data reading for child pages, I switched to Remix's `<Outlet>` for nested pages.
Outlets are a way of telling components where to render their children.
The children pages bring their own loader and action functions. They know how to read their own data and they provide the logic to handle data writes such as form submissions.

This allowed me to replace custom client-server communication (lots of manual `POST`) with [fetcher](https://remix.run/docs/en/v1/api/remix#usefetcher) or even [&lt;Form&gt;](https://remix.run/docs/en/v1/api/remix#form). Remix gives you "loading" or "pending" states for free. There is no need to keep track of the state anymore by doing something like this:

```typescript
const [isLoading, setIsLoading] = useState<boolean>(false)
const [isSubmitted, setIsSubmitted] = useState<boolean>(false)

useEffect(() => {
  if (isSubmitted) {
    setIsLoading(true)
    // submit here
    .finally(() => setIsLoading(false))
    setIsLoading(false)
  }
}, [isSubmitted])
```


### Server-side rendering (SSR) {#server-side-rendering--ssr}

The most painful part of the migration was server-side rendering (SSR) of third-party components (= React components from NPM). In the browser, both Next.js and Remix are just running React. Consequentially, what works in the browser on Next.js works on Remix.

Rendering on the server, on the other hand, is painful. Many third party React components have a section about SSR. Unfortunately, the instructions are valid for Next.js, sometimes for Gatsby. It seems that Remix is not yet a first-class React framework among React developers.

The component that I am still not able to render on the server is [react-select](https://react-select.com/) because of its use of emotion. A workaround using `<ClientOnly />` from [remix-utils](https://github.com/sergiodxa/remix-utils) fixed the issue.

```typescript
import Select from "react-select"
import { ClientOnly } from "remix-utils"

const CustomDropdown = () => {
  return (
    <ClientOnly>
      <Select />
    </ClientOnly>
  )
}
```

It is important to render place holders or empty components to avoid layout shift when the client-side rendering kicks in. In this case, the width depends on the rendered data. Hard coding `w-64` fixed the issue.

```typescript
import Select from "react-select"
import { ClientOnly } from "remix-utils"

const CustomDropdown = () => {
  return (
    <div className="w-64">
      <ClientOnly>
        <Select />
      </ClientOnly>
    </div>
  )
}
```


## Remix vs. Next.js {#remix-vs-dot-next-dot-js}


### Remix pros {#remix-pros}

1.  **Nested routes**: A powerful abstraction that allows the framework to optimize data fetching and provide an excellent DX by making error handling simpler and more explicit.
2.  **Data writes**: Remix provides mechanisms to submit forms and to write data in a more general way.
3.  **Use the platform**: There is a certain simplicity in using what is provided by the browser. The community seems to favor copying and customizing snippets over adding dependencies. I see similarities to the Go community, where people say "a little bit of duplication is better than an additional dependency".
    The official Remix Stacks are project templates that you adjust to your needs. There is no meta Remix framework that tries to abstract things away for you.
4.  **Faster**: Remix is 10-15% faster with the same code base in my tests. Keep in mind that the two deployment targets are different in my case. Next.js was deployed to Vercel and Remix is deployed to Cloudflare Workers. I did performance testing with WebPageTest.org, web.dev and Lighthouse.


### Remix cons {#remix-cons}

1.  **Small ecosystem**: Next.js has better support in the React SSR ecosystem. Helper components like `<Image>` are part of Next.js. Remix currently does not provide similar components.
2.  **Little Q&amp;A material**: The community is smaller and most of the answers are provided on the Remix Discord, which is not indexed by Google or Bing. Whenever I encounter issues, I run a query on Google and another one on Discord.
3.  **No specialized hosting platform**: Remix is built to be runtime agnostic, so it runs on the edge or on Node.js. The documentation and the community recommend to deploy Remix to fly.io or Cloudflare.
    However, there is no integrated solution like Vercel that is specialized in hosting Remix apps.
4.  **Magic**: The Remix compiler creates one bundle for the browser and one for the server from a single code base. This is not much different from how Next.js works. However, the additional abstractions for the data reads and the nested components come at a cost. In practice, these costs seem quite low and sometimes manifest in error messages that are hard to understand.


### Verdict {#verdict}

Both are great frameworks that make developing React apps a joy.

Remix was born out of the mature [React Router](https://www.google.com/search?q=react+router&oq=react+router&aqs=chrome..69i57j69i59j69i60l3j69i65l2j69i60.2077j0j7&sourceid=chrome&ie=UTF-8) library, but is much younger and more cutting edge than Next.js. The documentation is good, but if things go wrong you better be ready to hop on the Discord or read the source code. Reading the source code of the frameworks you use is a good idea anyway 😛.

Nested routes and a unified way to read and write data are big steps into the right direction.

The ecosystem is innovating top of the novel yet solid abstractions. Some third-party React components that work with Next.js are still painful to use with Remix on the server.