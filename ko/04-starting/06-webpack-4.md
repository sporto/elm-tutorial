> This page covers Elm 0.18

# Webpack 4

## package.json

서버를 쉽게 돌리기 위해 몇가지 npm 스크립트를 추가하겠습니다. __package.json__ 의 `scripts` 를 수정합니다:

```json
"scripts": {
    "api": "node api.js",
    "build": "webpack",
    "watch": "webpack --watch",
    "dev": "webpack-dev-server --port 3000"
},
```

- 이제 `npm run api` 로 API 서버를 돌릴 수 있습니다.
- `npm run build` 는 Webpack 빌드를 돌려 `dist` 에 번들을 내놓습니다.
- `npm run watch` 는 Webpack 와쳐 (watcher) 를 실행해 소스 코드 변경시마다 `dist` 를 만들어 냅니다.
- `npm run dev` 는 Webpack dev 서버를 실행합니다.

## Node Foreman

개발에 두 종류의 서버가 사용되고 있습니다: API 와 프론트엔드. 어플리케이션을 돌려 보려면 둘 다를 수동으로 실행해야 하는데, 뭐 별일은 아니지만 더 멋진 방법이 있습니다.

Node Foreman 을 설치합니다:

```
npm install -g foreman
```

`Procfile` 파일을 프로젝트 루트에 작성합니다:

```
api: npm run api
client: npm run dev
```

이제 CLI 에서 `nf` 명령으로 두 프로세스를 한번에 켜고 끌 수 있습니다.

## 테스트

이제 테스트 해봅시다.

터미널에서 아래 명령을 실행합니다:

```bash
nf start
```

브라우저로 `http://localhost:3000/` 에 접속하면 "Hello" 를 출력하는 어플리케이션을 볼 수 있습니다. 서버를 종료하려면 터미널에서 `Ctrl-c` 를 누릅니다.

현재까지 진행한 코드는 <https://github.com/sporto/elm-tutorial-app/tree/018-02-webpack> 과 같습니다.
