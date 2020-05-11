#### Jest.config.js

```

module.exports = {
  // 这个选项告诉Jest，应该自动模拟测试中所有导入的模块，测试中使用的所有模块都将具有替代实现，从而保持API外观。
  // automock: false,

  // 在 n 次失败后停止测试
  // bail: 0,

  // 解决模块时，请尊重package.json中的“浏览器”字段
  // browser: false,

  // jest依赖信息缓存目录
  // cacheDirectory: "/private/var/folders/59/x8j7sht14wv9q3k5zvt0w4fm0000gn/T/jest_dx",

  // 在每次测试之间自动清除模拟调用和实例
  // clearMocks: false,

  // 在测试时候是否收集覆盖率信息
  collectCoverage: true,

  // 指定收集覆盖率的信息源
  // collectCoverageFrom:[
    "**/*.{js,jsx}",
    "!**/node_modules/**",
    "!**/vendor/**"
  ],

  // 覆盖率文件输出目录
  coverageDirectory: '__test__/coverage',

  // 覆盖率信息忽略配置
  // coveragePathIgnorePatterns: [
  //   "/node_modules/"
  // ],

  // Jest在编写覆盖率报告时使用的报告人姓名列表
  // coverageReporters: [
  //   "json",
  //   "text",
  //   "lcov",
  //   "clover"
  // ],

  // 为覆盖结果配置最低阈值实施的对象
  // coverageThreshold: null,

  // 定制依赖项提取器的路径
  // dependencyExtractor: null,

  // 使调用过时的API抛出有用的错误消息
  // errorOnDeprecated: false,

  // 使用Glob模式数组从忽略的文件强制覆盖
  // forceCoverageMatch: [],

  // 导出异步功能的模块的路径，该异步功能在所有测试套件之前触发一次
  // globalSetup: null,

  // 导出异步功能的模块的路径，该异步功能在所有测试套件之后触发一次
  // globalTeardown: null,

  // 一组全局变量，需要在所有测试环境中使用
  // globals: {},

  // 用于运行测试的最大工作量。 可以指定为％或数字。 例如。 maxWorkers：10％将使用您的CPU数量的10％+ 1作为最大工/// 人数。 maxWorkers：2个最多使用2个工人。
  // maxWorkers: "50%",

  // 从需求模块的位置向上递归搜索的目录名称数组
  // moduleDirectories: [
  //   "node_modules"
  // ],

  // 模块使用的文件扩展名数组
  moduleFileExtensions: ['js', 'json', 'jsx', 'ts', 'tsx', 'node'],

  // 从正则表达式到模块名称的映射，允许使用单个模块存根资源
  moduleNameMapper: {
    '^@src(.*)$': '<rootDir>/src$1',
    // '.(css|scss|less)$': '<rootDir>/__test__/mock/styleMock.js',
  },

  // 一个正则表达式模式字符串数组，在被模块加载器视为“可见”之前，已与所有模块路径匹配
  // modulePathIgnorePatterns: [],

  // 激活测试结果通知
  // notify: false,

  // 指定通知模式的枚举。 需要 {notify：true}
  // notifyMode: "failure-change",

  // 用作Jest配置基础的预设
  // preset: null,

  // 从一个或多个项目运行测试
  // projects: null,

  // 使用此配置选项将自定义报告程序添加到Jest
  // reporters: undefined,

  // 每次测试之间自动重置模拟状态
  // resetMocks: false,

  // 在运行每个单独的测试之前，请重置模块注册表
  // resetModules: false,

  // 自定义解析器的路径
  // resolver: null,

  // 在每次测试之间自动恢复模拟状态
  // restoreMocks: false,

  // Jest应该在其中扫描测试和模块的根目录
  rootDir: './',

  // Jest用于在其中搜索文件的目录的路径列表
  // roots: [
  //   "<rootDir>"
  // ],

  // 允许您使用自定义运行器，而不是Jest的默认测试运行器
  // runner: "jest-runner",

  // 在每次测试之前运行一些代码以配置或设置测试环境的模块的路径
  // setupFiles: [],
  setupFiles: ['./setupTests.js'],

  // 在每次测试之前运行一些代码以配置或设置测试框架的模块的路径列表
  // setupFilesAfterEnv: [],

  // Jest用于快照测试的快照序列化程序模块的路径列表
  // snapshotSerializers: [],

  // 用于测试的测试环境
  // testEnvironment: "jest-environment-jsdom",

  // 将传递给testEnvironment的选项
  // testEnvironmentOptions: {},

  // 添加位置字段以测试结果
  // testLocationInResults: false,

  // 测试匹配
  testMatch: ['<rootDir>/__test__/**/*.(spec|test).[jt]s?(x)'],

  // Jest忽略检测的测试文件的regexp模式或模式数组
  // testPathIgnorePatterns: [
  //   "/node_modules/"
  // ],

  // Jest用于检测测试文件的regexp模式或模式数组
  // testRegex: [],

  // 自定义结果运行器
  // testResultsProcessor: null,

  // 自定义测试运行器
  // testRunner: "jasmine2",

  // This option sets the URL for the jsdom environment. It is reflected in properties such as location.href

  // testURL: "http://localhost",
  testURL: 'https://test.com?empty=&num=0&str=str&cstr=中文&encode=%e4%b8%ad%e6%96%87',

  // 将此值设置为“fake”可将虚假计时器用于“setTimeout”等功能
  // timers: "real",

  // 从正则表达式到转换器路径的映射
  transform: {
    '^.+\\.[t|j]sx?$': 'babel-jest',
    '^.+\\.(css|scss|less)$': '<rootDir>/__test__/mock/cssTransform.js',
    '\\.(jpg|jpeg|png|gif|eot|otf|webp|svg|ttf|woff|woff2|mp4|webm|wav|mp3|m4a|aac|oga)$':
      '<rootDir>/__test__/mock/fileTransform.js',
  },

  // 与所有源文件路径匹配的regexp模式字符串数组，匹配的文件将跳过转换
  // transformIgnorePatterns: [
  //   "/node_modules/"
  // ],

  // 不需要mock的模块正则匹配
  // unmockedModulePathPatterns: undefined,

  // 指示是否应在运行期间报告每个测试
  // verbose: null,

  // 在监视模式下重新运行测试之前，与所有源文件路径匹配的一组regexp模式
  // watchPathIgnorePatterns: [],

  // 是否使用watchman
  // watchman: true,
}

```
