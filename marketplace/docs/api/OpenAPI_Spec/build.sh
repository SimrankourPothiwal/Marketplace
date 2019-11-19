echo "Generating final OpenAPI document"
echo "Using swagger-merger version $(npx -q swagger-merger -V)"
npx -q swagger-merger -i index.yaml -o 7NOW_Marketplace_API.yaml
echo "Generated file 7NOW_Marketplace_API.yaml"
echo "Linting file"
npx -q swagger-cli validate 7NOW_Marketplace_API.yaml
echo "Done!"