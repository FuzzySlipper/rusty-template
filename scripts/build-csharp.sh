#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
product_project="$repo_root/src/RustyTemplate.NativeProduct/RustyTemplate.NativeProduct.csproj"

dotnet build "$repo_root/src/RustyTemplate.Game/RustyTemplate.Game.csproj" --configuration Release
dotnet publish "$product_project" --configuration Release --runtime linux-x64 --self-contained true
