#!/usr/bin/env bats

load 'test/helpers/mocks/stub'
load 'test/helpers/support/load'
load 'test/helpers/assert/all'

setup() {
  rm -rf "$BATS_MOCK_BINDIR"
}

teardown() {
  unstub curl || true
}

@test 'post-update: outside git repo' {
  repo="$(mktemp --directory)"

  pushd "$repo" > /dev/null
  cp "$BATS_CWD/teamcity post-update or update.sample" 'post-update'
  chmod +x 'post-update'

  run "./post-update"
  popd > /dev/null

  assert_failure

  assert_output_contains 'post-update: Cannot determine git repository directory.'
}

@test 'post-update: git config values unset' {
  vars=(baseurl user password buildids)

  for var in "${vars[@]}"; do
    repo="$(mktemp --directory)"

    pushd "$repo" > /dev/null
    git init --quiet

    for v in "${vars[@]}"; do
      [[ "$v" == "$var" ]] && continue

      git config "hooks.teamcity.$v" "$v"
    done

    cp "$BATS_CWD/teamcity post-update or update.sample" '.git/hooks/post-update'
    chmod +x '.git/hooks/post-update'

    run "./.git/hooks/post-update"
    popd > /dev/null

    assert_failure

    assert_output_contains "post-update: hooks.teamcity.$var is unset. Please configure it with:"
  done
}

@test 'post-update: branch deletion' {
  repo="$(mktemp --directory)"

  pushd "$repo" > /dev/null
  git init --quiet
  git config hooks.teamcity.baseurl baseurl
  git config hooks.teamcity.user user
  git config hooks.teamcity.password password
  git config hooks.teamcity.buildids 'one two'

  cp "$BATS_CWD/teamcity post-update or update.sample" '.git/hooks/post-update'
  chmod +x '.git/hooks/post-update'

  run "./.git/hooks/post-update" <<< 'old 0000000000000000000000000000000000000000 refs/heads/master'
  popd > /dev/null

  assert_success

  assert_line 'Skipped triggering build for refs/heads/master because is has been deleted (0000000).'
}

@test 'post-update: branch update' {
  repo="$(mktemp --directory)"

  pushd "$repo" > /dev/null
  git init --quiet
  git config hooks.teamcity.baseurl baseurl
  git config hooks.teamcity.user user
  git config hooks.teamcity.password password
  git config hooks.teamcity.buildids 'one two'

  touch 1
  git add 1
  git commit --quiet --message 1
  head="$(git rev-parse HEAD)"
  head_short="$(git rev-parse --short HEAD)"

  stub curl

  cp "$BATS_CWD/teamcity post-update or update.sample" '.git/hooks/post-update'
  chmod +x '.git/hooks/post-update'

  run "./.git/hooks/post-update" <<< "old $head refs/heads/master"
  popd > /dev/null

  assert_success
  assert_line "Triggering build ID one for refs/heads/master@$head_short"
  assert_line "Triggering build ID two for refs/heads/master@$head_short"
  assert_line "Translated refs/heads/master to TeamCity logical branch name refs/heads/master."
}
