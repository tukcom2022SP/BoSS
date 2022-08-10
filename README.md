<h1>맛집 정보 공유 앱 - '맛이 어때'</h1>

**나만의 맛집을 지도에 표시하여 사용자들끼리 맛집 정보를 공유하세요.**


<h2>앱 동작 화면</h2>

![loading](https://user-images.githubusercontent.com/87902884/183897113-41360642-3899-44cc-b15a-9ddf377e8c12.gif)
![myLocation](https://user-images.githubusercontent.com/87902884/183896947-039870c0-0272-407d-acc1-0de96983cf3b.gif)
![storeAdd](https://user-images.githubusercontent.com/87902884/183897272-45c48e23-5752-4968-8cb5-6037ef1ac647.gif)
![storeList](https://user-images.githubusercontent.com/87902884/183897409-7703ea1b-b307-4745-be34-0ed661f8a9c6.gif)
![ezgif com-gif-maker](https://user-images.githubusercontent.com/87902884/183897839-f44797d1-8879-478b-96cf-18bda1c1e25e.gif)

<h2>Branch 전략</h2>


![title](https://media.vlpt.us/images/yejine2/post/e6833c35-f4ff-493a-b5a2-b4cd82f91f13/git-flow.png)   
[이미지 출처: [How to Use GitFlow](https://www.campingcoder.com/2018/04/how-to-use-git-flow/)]

#### main 브랜치
- 기준이 되는 브랜치로 사용자에게 제품이 배포됨.
- main 브랜치에서 개발을 진행하면 안됨.

#### develop 브랜치
- develop 브랜치 위에서 자유롭게 개발자들이 작업. 
- develop 브랜치를 개발할 때는 feature브랜치를 따서 feature브랜치 위에서 작업.

#### hotfix 브랜치
- main 브랜치의 서브용으로 프로젝트를 긴급 수정해야할 때 사용하는 브랜치.
- 완료된 hotfix 브랜치는 하나는 main, 다른 하나는 develop 브랜치와 병합.

#### feature 브랜치
- 새로운 기능을 추가하는 브랜치로 develop 브랜치로부터 파생.
- 기능 추가 완료 후 develop 브랜치에 병합.

<h2>Commit 전략</h2>

1. 커밋 메시지 제목에 타입을 표시

    ex) Type : Commit Message

2. 커밋 종류
    - feat 	: 새로운 기능 추가
    - fix 		: 버그 수정
    - docs 	: 문서 수정
    - style 	: 코드 formatting, 세미콜론(;) 누락, 코드 변경이 없는 경우
    - refactor : 코드 리팩토링
    - test 	: 테스트 코드, 리팩토링 테스트 코드 추가
    - chore 	: 빌드 업무 수정, 패키지 매니저 수정

<h2>링크</h2>

[Trello](https://trello.com/b/UIdCI9Gk/boss)   

[Prototype](https://ovenapp.io/view/4hEuGyQFFgbREUzjkCejf8hXx55jISWM/)


<h2>기술 </h2>

<img src="https://img.shields.io/badge/Swift-F05138?style=flat-square&logo=swift&logoColor=white"/> <img src="https://img.shields.io/badge/Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=white"/>

<h2>팀원</h2>

| 이름 | 이승현 | 이정동 | 박준희 |
| --- | --- | --- | --- |
| GitHub | [@hyuuuun](https://github.com/hyuuuun) | [@ljdongz](https://github.com/ljdongz) | [@junhxx](https://github.com/junhxx) |
| 역할 | - | - | - |



