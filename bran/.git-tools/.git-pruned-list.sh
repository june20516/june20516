#!/bin/bash

# 색상 코드 정의
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# --- 스크립트 시작 ---
echo -e "${CYAN}🔍 원격 저장소와 로컬 브랜치 목록을 동기화합니다...${NC}"

# 1. 원격 저장소의 최신 정보를 가져오고, 삭제된 브랜치는 로컬의 원격 추적 브랜치에서도 제거 (prune)
git remote update origin --prune
echo -e "${GREEN}✓ 동기화 완료${NC}"

# 2. 인자(prefix) 확인
PREFIX=$1
if [ -z "$PREFIX" ]; then
    echo -e "${YELLOW}ℹ️  remote에서 제거된 모든 브랜치 검색${NC}"
else
    echo -e "${YELLOW}ℹ️  remote에서 제거된 '${PREFIX}' 로 시작하는 브랜치 검색${NC}"
fi

# 3. 로컬에만 존재하는 브랜치 목록 생성
# git branch -vv: 각 브랜치의 업스트림 정보를 보여줌. [origin/...: gone] 이 포함된 라인을 찾음
PRUNED_BRANCHES=$(git branch -vv | grep ': gone]' | awk '{print $1}')

# 4. 접두사로 필터링 (필요시)
if [ -n "$PREFIX" ]; then
    PRUNED_BRANCHES=$(echo "$PRUNED_BRANCHES" | grep "^$PREFIX")
fi

# 5. 결과 출력
if [ -z "$PRUNED_BRANCHES" ]; then
    echo -e "\n${GREEN}✨ 정리할 로컬 브랜치가 없습니다${NC}"
else
    echo -e "\n${YELLOW}🧹 remote에 존재하지 않는 브랜치 목록:${NC}"
    # 결과를 한 줄씩 예쁘게 출력
    echo "$PRUNED_BRANCHES" | while IFS= read -r line; do echo -e "  - ${line}"; done
fi

exit 0


# 실행 권한 부여해야 함
# chmod +x ~/.git-tools/.git-pruned-list.sh
