## 🤔 撸一个 webpack

> webpack 是一个现代 JavaScript 应用程序的静态模块打包工具。当 webpack 处理应用程序时，它会在内部构建一个 依赖图(dependency graph)，此依赖图会映射项目所需的每个模块，并生成一个或多个 bundle。

<br/>
#### 一、几个基础概念:

<code>chunk: </code>bundle 是由许多个 chunk 组成的，通常 chunkh 和 bundle 一一对应，但也有一对多的关系

- <code>entry chunk</code>
  - 包含 webpack runtime code 并且是最先执行的 chunk
- <code>initial chunk</code>
  - 包含同步加载进来的 module 且不包含 runtime code 的 chunk
  - 在 entry chunk 执行后再执行的
- <code>normal chunk</code>
  - 使用 require.ensure、import()异步加载进来的 module，会被放到 normal chunk 中

<code>bundle:</code> 由多个不同的模块产生，它是已经加载完毕和被编译后的源代码的最终版本<br/>
<code> graph:</code> 用来描述文件之间的依赖关系的图。从入口起点开始以递归的方式构建各个文件之间的依赖关系<br/>
<code>loader:</code> 资源正确加载的加载器<br/>
<code>plugins:</code>增强型功能插件 与<code>loader</code>互补<br/>

#### 二、什么是模块

<code>模块</code> <font size=1>是一组与特定功能相关的代码。它封装了实现细节，公开了一个公共 API，并与其他模块结合以构建更大的应用程序。</font><br/>
<code>模块化</code> 就是为了实现更高级别的抽象，它将一类或多种实现封装到一个模块中，我们不必考虑模块内是怎样的依赖关系，仅仅调用它暴露出来的 API 即可<br/>
例如:

```
**[terminal]
<html>
  <script src="/src/man.js"></script>
  <script src="/src/person.js"></script>
</html>
```

其中 person.js 中依赖 man.js ，在引用时如果你把它们的引用顺序颠倒就会报错。在大型项目中，这种依赖关系就显得尤其重要，而且极难维护.<br/>除此之外，它还有以下问题：

- 一切都加载到全局上下文中，导致名称冲突和覆盖
- 涉及开发人员的大量手动工作，以找出依赖关系和包含顺序

所以，模块化非常重要 ！！！

由于前后端 JavaScript 分别搁置在 HTTP 的两端，它们扮演的角色不同，侧重点也不一样。 浏览器端的 JavaScript 需要经历从一个服务器端分发到多个客户端执行，而服务器端 JS 则是相同的代码需要多次执行。前者的瓶颈在于宽带，后者的瓶颈则在于 CPU 等内存资源。前者需要通过网络加载代码，后者则需要从磁盘中加载， 两者的加载速度也不是在一个数量级上的。 所以前后端的模块定义不是一致的，其中服务器端的模块定义为:

- CJS（CommonJS）：旨在用于服务器端 JavaScript 的同步定义，Node 的模块系统实际上基于 CJS；

? 但是 CJS 是同步方式，那么问题来了：

- 服务端：文件都在本地，即使卡住主线程依然不会受到太大的影响，
- 浏览器端： 如果 UI 线程被阻塞，需要等待大量的网络请求和脚本执行完成，那么将带来极大的开销，并且大大降低用户体验

SO，前端的浏览器模块定义来了:

- AMD（异步模块定义）：被定义为用于浏览器中模块的异步模型，RequireJS 是 AMD 最受欢迎的实现；
- UMD（通用模块定义）：它本质上一段 JavaScript 代码，放置在库的顶部，可让任何加载程序、任何环境加载它们；
- ES2015（ES6）：定义了异步导入和导出模块的语义，会编译成 require/exports 来执行的，这也是我们现今最常用的模块定义；

#### 三、什么是打包器

<code>打包器</code> 就是把 javascript 模块化代码转化为浏览器可识别运行的优化工具

<code>常用打包工具</code> webpack、rollup、gulp、grunt

举个例子，你在一个 html 文件中引入多个 JavaScript 文件：

```
**[terminal]
<html>
  <script src="/src/entry.js"></script>
  <script src="/src/message.js"></script>
  <script src="/src/hello.js"></script>
  <script src="/src/name.js"></script>
</html>
```

Graph 关系
![依赖关系图谱](/assets/images/graph.png)

##### 模块化

在 HTML 引入时，我们需要注意这 4 个文件的引入顺序（如果顺序出错，项目就会报错），如果将其扩展到具有实际功能的可用的 web 项目中，那么可能需要引入几十个文件，依赖关系更是复杂。

所以，我们需要将每个依赖项模块化，让打包器帮助我们管理这些依赖项，让每个依赖项能够在正确的时间、正确的地点被正确的引用

##### 捆绑

另外，当浏览器打开该网页时，每个 js 文件都需要一个单独的 http 请求，即 4 个往返请求，才能正确的启动你的项目。

我们知道浏览器加载模块很慢，即使是 HTTP/2 支持有效的加载许多小文件，但其性能都不如加载一个更加有效（即使不做任何优化）。

所以 我们可以将文件最终合并为一个，但是又可以让这哥文件可以和通过某种依赖关系，动态加载资源

```
**[terminal]
<html>
  <script src="/dist/bundle.js"></script>
</html>
```

如此以来，便只有一次网络请求啦

#### 四、如何打包

1. 解析入口文件，并获取相关的依赖
2. 递归遍历所有文件之间的依赖关系，生成依赖图
3. 使用依赖关系图，生成一个浏览器可以执行的函数(IIFE)
   - IIFE 立即执行函数，由于 JavaScript 变量的作用域仅限于函数内部，所以你不必考虑它会污染全局变量。<br/>
4. 通过文件流将生成的文件字符串输出到 output 指定的文件中
   <code>fs.writeFile</code> 写入 dist/bundle.js 即可。

#### 五、写在最后

其实 webpack 最核心的部分就在于 graph 依赖图，将依赖的资源的 code 包装在一个 IIFE 里便生成了 bundle.js 文件。

具体代码实现就不贴下来了，给大家一些思考的空间，下面介绍几个会用到的 babel 包并奉上 graph 依赖结构图

- babel 包

```
**[terminal]
const babelParser = require('@babel/parser');
const { transformFromAst } = require('@babel/core');
const traverse = require('@babel/traverse').default;

// 将模块内容转换为抽象语法树AST
const ast = babelParser.parse(content, {
    sourceType: 'module',
});
// 将抽象语法树转换为code
const { code } = transformFromAst(ast, null, {
    presets: ['@babel/preset-env'],
});
// 根据抽象语法树获取对应的文件依赖
traverse(ast, {
      // 遍历所有的 import 模块，并将相对路径放入 dependencies
      ImportDeclaration: ({ node }) => {
        dependencies.push(node.source.value);
      },
});
```

- graph 依赖关系图

```
**[terminal]
let graph = {
  []// entry 模块
  "src/entry.js": {
    code: '',
    dependencies: ["./src/message.js"],
    mapping:{
      "./message.js": "src/message.js"
    }
  },
  // message 模块
  "src/message.js": {
    code: '',
    dependencies: [],
    mapping:{},
  }
}
```

已经很晚了，这算是一个好的开始～

希望自己能一直坚持，不断的提升自己～

也希望阅读到此文章的您能有所收获～