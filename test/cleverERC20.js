const ERC20 = artifacts.require("ERC20");

contract("ERC20", accounts => {
  let erc20Instance;

  beforeEach(async () => {
    erc20Instance = await ERC20.new("clevertoken", "CT", 18, web3.utils.toWei("1000"));
  });

  it("should have correct token details", async () => {
    const name = await erc20Instance.name();
    const symbol = await erc20Instance.symbol();
    const decimals = await erc20Instance.decimals();
    const totalSupply = await erc20Instance.totalSupply();

    assert.equal(name, "clevertoken", "Incorrect token name");
    assert.equal(symbol, "CT", "Incorrect token symbol");
    assert.equal(decimals, 18, "Incorrect token decimals");
    assert.equal(totalSupply, web3.utils.toWei("1000"), "Incorrect total supply");
  });

  it("should transfer tokens correctly", async () => {
    const initialBalance = await erc20Instance.balanceOf(accounts[0]);
    const amount = web3.utils.toWei("10");

    await erc20Instance.transfer(accounts[1], amount, { from: accounts[0] });

    const finalBalanceSender = await erc20Instance.balanceOf(accounts[0]);
    const finalBalanceReceiver = await erc20Instance.balanceOf(accounts[1]);

    assert.equal(finalBalanceSender.toString(), initialBalance.sub(amount).toString(), "Incorrect sender balance after transfer");
    assert.equal(finalBalanceReceiver.toString(), amount.toString(), "Incorrect receiver balance after transfer");
  });

  // Add more test cases for other functionalities like allowance, transferFrom, etc.
});
