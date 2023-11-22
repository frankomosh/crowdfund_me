use starknet::ContractAddress;

#[starknet::interface]
trait ICrowdfundme<TContractState> {
    fn propose_funding_request(ref self: TContractState, amount: u128, description: felt252) -> u32;
    fn vote_on_request(ref self: TContractState, request_id: u32, approve: bool);
    fn get_total_amount_raised(self: @TContracState) -> u128;
    fn get_total_contributors(self: @TContractState) -> u32;
}
#[starknet::contract]
mod CrowdfundmeContract {
    use starknet::ContractAddress;
    #[storage]
    struct Storage {
        funding_requests: LegacyMap::<u128, FundingRequest>,
        contributions: LegacyMap<ContractAddress, u64>,
        total_amount_raised: u128,
        total_contributors: u32,
    }
    #[event]
    #[derive(Drop, starknet::Event)]
    struct FundingRequest {
        amount_requested: u128,
        amount_approved: u128,
        description: felt252,
        approved_votes: u32,
        rejected_votes: u32,
        is_complete: bool,
    }
}
