git config --local gitflow.branch.master master
git config --local gitflow.branch.develop dev

git flow init -d -f

git config --local gitflow.prefix.feature feature/
git config --local gitflow.prefix.bugfix bugfix/
git config --local gitflow.prefix.release release/
git config --local gitflow.prefix.hotfix hotfix/
git config --local gitflow.prefix.support support/
git config --local gitflow.prefix.versiontag v
git config --local gitflow.feature.finish.no-ff true
git config --local gitflow.feature.start.fetch true
git config --local gitflow.feature.finish.fetch true