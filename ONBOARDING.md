# 게임빌더 스킬 — 팀원 온보딩

이 가이드는 사내 **게임빌더(game-builder) Claude Code 스킬**을 설치·사용하는 법입니다.
이 문서를 Claude Code에 읽히면 Claude가 알아서 설치를 도와줍니다.

## 이게 뭐냐
아이디어 한 줄 던지면 **플레이 가능한 단일 HTML 게임 1파일**을 만들어주는 Claude Code 스킬.
- 아케이드·퍼즐·클리커·보드/카드·.io·슈팅·3D 캐주얼 등
- 결과물 = HTML 1파일 → 더블클릭으로 어디서나 플레이, 그대로 공유 가능
- **엔진 = 본인의 Claude Code 구독** (중앙 서버·API 키 없음. 각자 자기 계정으로)

## 설치 (둘 중 하나)

### 방법 1 — 어디서나 쓰기 (개인 스킬, 추천)
repo를 클론한 뒤 루트에서:
```bash
git clone https://github.com/shawn-kim-axz/ntf-game-builder
cd ntf-game-builder
./install.sh
```
`~/.claude/skills/game-builder` 로 복사됩니다. 이제 **아무 폴더**에서 Claude Code를 열어도 스킬이 잡힙니다.

(수동으로 하려면: `cp -r .claude/skills/game-builder ~/.claude/skills/`)

### 방법 2 — 이 repo 안에서만 쓰기
이 repo(`ntf-game-builder`) 폴더에서 Claude Code를 열면 프로젝트 스킬로 **자동 인식**됩니다. 처음 열 때 폴더 신뢰(workspace trust)를 허용하세요.

## 사용법
Claude Code에서 그냥:
```
게임 만들어줘 — 공룡 점프 게임
```
또는
```
/game-builder 2048 변형 퍼즐
```
그러면 Claude가: 아이디어 확인 → 게임 생성(`games/<이름>.html`) → 자가점검 → 브라우저로 열어줌.
플레이해보고 **"더 빠르게 / 적 추가 / 버그있음"** 처럼 한 줄 피드백 주면 같은 파일을 고쳐서 다시 열어줍니다.

## 주의
- 스킬이 신뢰된 폴더에서 `open`/`node`/`mkdir`을 자동 실행합니다(생성-플레이 빠른 반복용).
- 만들 수 없는 것: 실시간 멀티플레이(서버 필요), 대량 원본 아트(이미지생성 의존), 대형 3D. → 이런 요청은 단일 HTML 대안으로 안내됩니다.

## 막히면
- 스킬이 안 잡히면: 방법 1로 설치했는지(`~/.claude/skills/game-builder` 존재?) 확인, Claude Code 재시작.
- 그 외 이슈는 이 repo 관리자에게 문의.
