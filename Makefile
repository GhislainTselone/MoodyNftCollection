-include .env

deploy:; forge script script/DeployMoodyNft.s.sol:DeployMoodyNft --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(API_KEY) -vvvv
mint:; forge script script/Interactions.s.sol:StartMinting --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast
imageUri:; forge script script/Interactions.s.sol:GetDisplayedImageUri --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast