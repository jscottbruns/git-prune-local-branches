#!/bin/bash
CURRENT_BRANCH=`git branch | grep "*" | sed 's/* //'`
if [[ "$CURRENT_BRANCH" != "master" ]]; then
  git checkout master > /dev/null 2>&1 && git pull > /dev/null 2>&1
fi

echo "Branches that can be removed..."
echo

MERGED_BRANCHES=`git branch --merged | grep -v "\*" | grep -v master`

if [[ "$MERGED_BRANCHES" != "" ]]; then
  echo "$MERGED_BRANCHES"
  echo
  echo -n "Do you want to remove these local branches? [y/N] "

  read doit
  echo 

  if [[ "$doit" == 'y' || "$doit" == 'Y' ]]; then
    for branch in $MERGED_BRANCHES; do
      if [[ "$CURRENT_BRANCH" == "$branch" ]]; then
        CURRENT_BRANCH=''
      fi

      git branch -d $branch
    done
    echo
  fi
else
  echo "All your local branches have already been merged"
  echo
fi

if [[ "$CURRENT_BRANCH" != "master" && "$CURRENT_BRANCH" != '' ]]; then
  git checkout $CURRENT_BRANCH > /dev/null 2>&1
fi
