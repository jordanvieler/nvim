set complete+=k~/finances/myledger/accounts.ledger
set dictionary=~/finances/myledger/accounts.ledger
set iskeyword+=:

command Clean :%s/\s*\$/  $/g
