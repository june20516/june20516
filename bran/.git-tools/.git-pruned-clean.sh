#!/bin/bash

# 색상 코드 정의
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# --- 스크립트 시작 ---
echo -e "${CYAN}🧹 불필요한 로컬 브랜치 정리 시작...${NC}"

# 1. 인자(prefix) 확인 (필수)
PREFIX=$1
if [ -z "$PREFIX" ]; then
    echo -e "\n${RED}❌ 정리할 브랜치의 Prefix 를 반드시 지정해야 합니다${NC}"
    echo -e "   예시: git pruned-clean feature/"
    exit 1
fi

# 2. 원격 저장소 정보 동기화
git remote update origin --prune > /dev/null 2>&1 # 로그가 중복되지 않도록 출력은 숨김

# 3. 접두사를 기준으로 삭제 대상 브랜치 목록 생성
BRANCHES_TO_DELETE=$(git branch -vv | grep ': gone]' | awk '{print $1}' | grep "^$PREFIX")

# 4. 삭제 대상 확인 및 사용자 동의
if [ -z "$BRANCHES_TO_DELETE" ]; then
    echo -e "\n${GREEN}✨ '${PREFIX}'에 해당하는 정리할 브랜치 없음 ${NC}"
    exit 0
fi

echo -e "\n${YELLOW}🚨 아래 브랜치들이 삭제됩니다:${NC}"
echo "$BRANCHES_TO_DELETE" | while IFS= read -r line; do echo -e "  - ${line}"; done

# 사용자에게 최종 확인 받기
read -p $'\n정말로 삭제하시겠습니까? (y/N) ' -n 1 -r REPLY
echo # 줄바꿈

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n${YELLOW} 작업 취소${NC}"
    exit 1
fi

# 5. 브랜치 삭제 실행
echo -e "\n${CYAN}🗑️ 브랜치 삭제 시작...${NC}"
echo "$BRANCHES_TO_DELETE" | while IFS= read -r branch; do
    git branch -D "$branch" # -d는 merge되지 않은 변경사항이 있으면 삭제를 막아주는 안전한 옵션
    if [ $? -eq 0 ]; then
        echo -e "  ${GREEN}✓ 삭제 완료: ${branch}${NC}"
    else
        echo -e "  ${RED}✗ 삭제 실패: ${branch}${NC}"
    fi
done

echo -e "\n${GREEN}✨ 브랜치 정리가 완료되었습니다${NC}"

exit 0

# 실행 권한 부여해야 함
# chmod +x ~/.git-tools/.git-pruned-clean.sh
