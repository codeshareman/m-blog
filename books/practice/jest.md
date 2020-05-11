## Jest

- Q: <code class="keyword">Jest</code> 如何生成配置文件 ？<br/>
- A: jest --init

- Q: <code class="keyword">Jest</code> 提示找不到 "@babel/preset-env" 怎么解决 ？<br/>
- A: Jest 在执行前会去读取 babel.config.js 或着 .babelrc 的配置，你需要去检查下是否有如下配置

  ```
    // .babelrc
     "test": {
      "presets": [["@babel/preset-env"], "@babel/preset-react", "@babel/preset-typescript"]
    }
  ```

- Q: <code class="keyword">Jest</code> 中如何解析 .ts|.tsx 的测试文件？<br/>
- A:

    ```
        // 安装 babel-jest
        yarn add babel-jest --dev
        // 在 jest.config.js 中配置
        {
            moduleFileExtensions: ['js', 'jsx', 'ts', 'tsx'],
            rootDir: './',
            transform: {
                // '^.+\\.tsx?$': 'ts-jest',
                '^.+\\.[t|j]sx?$': 'babel-jest',
            },
            testMatch: [
                '<rootDir>/__test__/*.(test|specs).[jt]s?(x)',
                // "**/__tests__/**/*.[jt]s?(x)"
                //   "**/?(*.)+(spec|test).[tj]s?(x)"
            ],
        }
    ```

- Q: <code class="keyword">enzyme</code> 如何对 react 项目进行单元测试<br/>
- A:

  ```
  // step 1
  yarn add enzyme @types/enzyme --dev
  yarn add enzyme-adapter-react-16 --dev

  // step 2 创建一个配置文件 setupFiles -> enzyme.config.js
  import Enzyme from 'enzyme'
  import Adapter from 'enzyme-adapter-react-16'
  Enzyme.configure({ adapter: new Adapter() })

  // step 3 在jest.config.js中配置
  setupFiles: ['./enzyme.config.js'],

  // step 4 在package.json中指定jest配置文件
  {
      "test": "jest --config ./jest.config.js"
  }
  ```
