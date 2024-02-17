

/*select vaults.* , currencies.curr_code from vaults 
left join currencies on vaults.currency_id = currencies.id
where agent_id = '0b14b0a7-b1f4-4b34-9e36-912f2cf348f7';*/

/*select transactions.customer_name , 
transactions.rate ,
transactions.action,
transactions.currency_code ,
transactions.exchange_currency_code,
transactions.agent_id,
vault_transactions.type ,
vault_transactions.amount,
agents.name from transactions
left join vault_transactions 
on transactions.id =  vault_transactions.transaction_id
left join agents on agents.id = transactions.agent_id
where transactions.id = '53c52592-79fa-4197-977a-983d24689b23'*/