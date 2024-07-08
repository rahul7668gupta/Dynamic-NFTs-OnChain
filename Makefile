-include .env

deploy-basic-nft-sepolia:;
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft --broadcast --rpc-url $(SEPOLIA_RPC_URL) --account $(ACCOUNT_WALLET) --verify --etherscan-api-key $(ETHERSCAN_API_KEY)

mint-basic-nft:;
	@forge script script/Interactions.s.sol:MintBasicNft --broadcast --rpc-url $(SEPOLIA_RPC_URL) --account $(ACCOUNT_WALLET)

deploy-mood-nft-sepolia:;
	@forge script script/DeployMoodNft.s.sol:DeployMoodNft --broadcast --rpc-url $(SEPOLIA_RPC_URL) --account $(ACCOUNT_WALLET) --verify --etherscan-api-key $(ETHERSCAN_API_KEY)

deploy-mood-nft-anvil:;
	@forge script script/DeployMoodNft.s.sol:DeployMoodNft --broadcast --rpc-url $(ANVIL_URL)