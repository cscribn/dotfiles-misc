# ============================================================================
# Terminal-Icons — replace EVERY Nerd Font glyph with a plain UTF-8 / emoji
#   character, so `Get-ChildItem` looks right with no Nerd Font installed.
#
# HOW THIS WORKS (and why it's not just a pile of Set-TerminalIconsIcon calls):
#   Terminal-Icons keeps two separate tables:
#     1. A per-theme map of "well-known name / extension -> glyph NAME"
#        e.g. '.ps1' -> 'nf-md-console_line'
#     2. A private $glyphs table of "glyph NAME -> actual character"
#        e.g. 'nf-md-console_line' -> the Nerd Font codepoint
#   Set-TerminalIconsIcon (and the older/removed Set-TerminalIconsExtensionIcon)
#   only let you point table #1 at a DIFFERENT EXISTING glyph name — you can't
#   hand it a raw emoji, because it still gets looked up in table #2 afterward
#   and an unknown name resolves to nothing (a blank icon).
#
#   So instead this script reaches into the module's private glyph table (#2)
#   and overwrites every glyph name the built-in 'devblackops' theme actually
#   uses with a plain character. Every file/folder/extension that currently
#   maps to that glyph name then renders the new character automatically —
#   132 glyph names cover 100% of what the default theme uses.
#
# USAGE: Import-Module Terminal-Icons must run first. dd `.
# "$PSScriptRoot\Terminal-Icons.Emoji.ps1"` after your `Import-Module
# Terminal-Icons` line.
# ============================================================================

$tiModule = Get-Module Terminal-Icons
if (-not $tiModule) {
    throw "Terminal-Icons failed to load."
}

# Live reference to the module's private glyph-name -> character table.
# (Module scriptblocks can read module-scoped variables; since a hashtable is
# a reference type, mutating what we get back here mutates the module's copy.)
$glyphTable = & $tiModule { $glyphs }

# Glyph NAME -> UTF-8 / emoji character. Every key below is a glyph name used
# somewhere by the default 'devblackops' icon theme (directories, well-known
# files, and extensions) — verified 1:1 against Data/iconThemes/devblackops.psd1.
$emojiMap = @{
    # ---- Defaults & links (files/folders) ----
    'nf-oct-file_directory'         = '📁'  # default folder
    'nf-cod-file_symlink_directory' = '🔗'  # symlinked folder / shortcuts / links
    'nf-fa-external_link'           = '🔀'  # junction
    'nf-fa-file'                    = '📄'  # default file
    'nf-oct-file_symlink_file'      = '🔗'  # symlinked file

    # ---- Well-known directories ----
    'nf-oct-repo'                   = '📚'  # docs / documents
    'nf-md-desktop_classic'         = '🖥️' # desktop
    'nf-md-timer'                   = '⏱️' # benchmark
    'nf-cod-preview'                = '👁️' # demo / samples
    'nf-md-contacts'                = '👤'  # contacts
    'nf-md-apps'                    = '🧩'  # apps / applications
    'nf-cod-package'                = '📦'  # artifacts
    'nf-fa-font'                    = '🔤'  # fonts
    'nf-md-folder_image'            = '🖼️' # images / photos / pictures
    'nf-md-movie'                   = '🎬'  # videos / movies
    'nf-dev-html5_multimedia'       = '🎞️' # media
    'nf-md-music_box_multiple'      = '🎵'  # music / songs
    'nf-dev-onedrive'               = '☁️'  # onedrive
    'nf-md-folder_download'         = '⬇️'  # downloads
    'nf-oct-terminal'               = '💻'  # src / development
    'nf-seti-project'               = '🗂️' # projects
    'nf-oct-file_binary'            = '🔢'  # bin
    'nf-md-test_tube'               = '🧪'  # tests
    'nf-fa-windows'                 = '🪟'  # windows
    'nf-fa-users'                   = '👥'  # users
    'nf-md-folder_star'             = '⭐'  # favorites
    'nf-cod-output'                 = '📤'  # output
    'nf-seti-config'                = '🔧'  # .config
    'nf-md-cached'                  = '🗃️' # .cache
    'nf-custom-folder_config'       = '⚙️'  # .vscode / .vscode-insiders
    'nf-custom-folder_git'          = '🌿'  # .git
    'nf-custom-folder_github'       = '🐙'  # .github
    'nf-fa-github_alt'              = '🐙'  # github
    'nf-custom-folder_npm'          = '📦'  # node_modules
    'nf-md-microsoft_azure'         = '☁️'  # .azure, azure-pipelines.yml
    'nf-dev-aws'                    = '🌩️' # .aws
    'nf-md-ship_wheel'              = '⚓'  # .kube
    'nf-dev-docker'                 = '🐳'  # .docker, Dockerfile, docker-compose*
    'nf-md-umbraco'                 = '🦋'  # umbraco

    # ---- Well-known files ----
    'nf-dev-git'                    = '🌿'  # .gitattributes/.gitconfig/.gitignore/.gitmodules/.gitkeep/.patch
    'nf-md-certificate'             = '📜'  # LICENSE
    'nf-fae-checklist_o'            = '📋'  # CHANGELOG*
    'nf-md-text_box_multiple'       = '📖'  # README*
    'nf-fa-file_o'                  = '📃'  # .DS_Store
    'nf-seti-json'                  = '🧾'  # tsconfig/tslint/composer.lock/etc.
    'nf-md-xml'                     = '🏷️' # .htaccess & xml-ish files
    'nf-fa-gear'                    = '⚙️'  # ini/conf/properties/settings/etc.
    'nf-seti-favicon'               = '🔖'  # favicon.ico
    'nf-dev-travis'                 = '🔨'  # .travis.yml
    'nf-fa-gitlab'                  = '🦊'  # .gitlab-ci.yml
    'nf-dev-jenkins'                = '🎩'  # jenkinsfile
    'nf-dev-bitbucket'              = '🪣'  # bitbucket-pipelines*
    'nf-seti-makefile'              = '🛠️' # makefile
    'nf-dev-firebase'               = '🔥'  # firebase.json / .firebaserc
    'nf-dev-bower'                  = '🎀'  # .bowerrc / bower.json
    'nf-fa-handshake_o'             = '🤝'  # code_of_conduct*
    'nf-md-vuejs'                   = '💚'  # vue.config.*, .vue
    'nf-dev-gulp'                   = '🥤'  # gulpfile*
    'nf-seti-grunt'                 = '😤'  # gruntfile.js
    'nf-dev-nodejs_small'           = '🟢'  # package(.lock).json, .nvmrc, .esmrc
    'nf-dev-npm'                    = '📦'  # .npmignore, .npmrc
    'nf-oct-person'                 = '🧑'  # authors*
    'nf-fa-lock'                    = '🔒'  # .terraform.lock.hcl, .lock
    'nf-md-elephant'                = '🧱'  # gradlew, .gradle

    # ---- Extensions ----
    'nf-oct-file_zip'               = '🗜️' # archives (.zip/.tar/.rar/...)
    'nf-custom-msdos'               = '🅱️'  # .bat / .cmd
    'nf-md-application'             = '▶️'  # .exe
    'nf-dev-perl'                   = '🐪'  # .pl
    'nf-md-package_variant'         = '📦'  # .msi/.msix/.deb/.rpm/...
    'nf-md-console_line'            = '⚡'  # PowerShell files
    'nf-dev-javascript'             = '🟨'  # .js/.esx/.mjs
    'nf-fae-java'                   = '☕'  # .java/.jar
    'nf-dev-python'                 = '🐍'  # .py
    'nf-md-notebook'                = '📓'  # .ipynb
    'nf-dev-react'                  = '⚛️'  # .jsx/.tsx
    'nf-seti-typescript'            = '🔷'  # .ts
    'nf-fa-archive'                 = '🗄️' # .dll
    'nf-dev-code_badge'             = '🏗️' # .clixml, terraform files
    'nf-md-file_excel'              = '📊'  # .csv/.tsv/.xls/.xlsx
    'nf-md-language_c'              = '🔵'  # .c
    'nf-md-language_cpp'            = '➕'  # .cpp/.cxx/.c++
    'nf-dev-go'                     = '🐹'  # .go
    'nf-dev-php'                    = '🐘'  # .php
    'nf-dev-visualstudio'           = '🟣'  # .csproj/.sln/.vb/...
    'nf-md-language_csharp'         = '♯'   # .cs/.csx
    'nf-dev-haskell'                = 'λ'   # .hs
    'nf-md-language_xaml'           = '📐'  # .xaml
    'nf-dev-rust'                   = '🦀'  # .rs
    'nf-dev-database'               = '💾'  # .sql/.mdb/.sqlite/...
    'nf-seti-db'                    = '📇'  # .db
    'nf-oct-ruby'                   = '💎'  # .rb/.erb/.gemfile/rakefile
    'nf-dev-fsharp'                 = '🎶'  # .fs/.fsx/.fsi/.fsproj
    'nf-fa-key'                     = '🔑'  # .pem/.pub/.key/.asc/.gpg
    'nf-fa-certificate'             = '📜'  # .cer/.cert/.crt/.pfx
    'nf-fa-calendar'                = '📅'  # .ics
    'nf-md-help_box'                = '❓'  # .chm
    'nf-fa-file_pdf_o'              = '📕'  # .pdf
    'nf-md-file_powerpoint'         = '📙'  # .pptx/.ppt/...
    'nf-md-file_word'               = '📘'  # .doc/.docx/.rtf
    'nf-fa-file_audio_o'            = '🎵'  # .mp3/.flac/.wav/...
    'nf-fa-file_image_o'            = '🖼️' # .png/.jpg/.gif/...
    'nf-md-svg'                     = '🖌️' # .svg
    'nf-fa-file_video_o'            = '🎬'  # .mp4/.mkv/.avi/...
    'nf-fa-eye'                     = '👁️' # .ass
    'nf-seti-html'                  = '🌐'  # .html/.htm/.xhtml/...
    'nf-dev-css3'                   = '🎨'  # .css
    'nf-dev-sass'                   = '💗'  # .sass/.scss
    'nf-dev-less'                   = '➖'  # .less
    'nf-dev-markdown'               = '✍️'  # .md/.markdown/.rst
    'nf-seti-mustache'              = '🥸'  # .hbs
    'nf-md-format_align_left'       = '📑'  # .yml/.yaml
    'nf-seti-lua'                   = '🌙'  # .lua
    'nf-dev-clojure'                = '🔮'  # .clj/.cljs/.cljc
    'nf-dev-groovy'                 = '🎷'  # .groovy
    'nf-dev-dart'                   = '🎯'  # .dart
    'nf-custom-elixir'              = '💧'  # .ex/.exs/.eex/.leex
    'nf-dev-erlang'                 = '📡'  # .erl
    'nf-custom-elm'                 = '🌳'  # .elm
    'nf-dev-apple'                  = '🍎'  # .applescript
    'nf-md-alpha_i'                 = 'ℹ️'  # .iLogicVb
    'nf-seti-bicep'                 = '💪'  # .bicep
    'nf-md-harddisk'                = '💽'  # .vmdk/.vhd/.vhdx
    'nf-fae-disco'                  = '💿'  # .img/.iso
    'nf-md-language_r'              = '📈'  # .R/.Rmd/.Rproj
    'nf-seti-julia'                 = '🟣'  # .jl
    'nf-custom-vim'                 = '⌨️'  # .vim
    'nf-custom-puppet'              = '🎭'  # .pp/.epp
    'nf-dev-scala'                  = '🪜'  # .scala/.sc/.sbt
    'nf-seti-svelte'                = '🧡'  # .svelte
    'nf-fa-list'                    = '🪵'  # .log
    'nf-md-file_document'           = '📝'  # .txt/.srt/.lrc
    'nf-dev-sublime'                = '🗒️' # .sublime-project/.sublime-workspace
}

foreach ($name in $emojiMap.Keys) {
    $glyphTable[$name] = $emojiMap[$name]
}
