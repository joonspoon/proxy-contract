const { expect } = require('chai');

describe('Box', function () {

  before(async function () {
    this.Box = await ethers.getContractFactory('Box');
  });

  beforeEach(async function () {
    this.box = await this.Box.deploy();
    await this.box.deployed();
  });

  it('retrieve returns a value previously stored', async function () {
    // Store a value
    await this.box.store(42);

    // Test if the returned value is the same one
    // We need to use strings to compare the 256 bit integers
    expect((await this.box.retrieve()).toString()).to.equal('42');
  });

  it('withdraw function exists after upgrade', async function () {
    await this.box.withdrawFeesCollected();
    expect((await this.box.retrieve()).toString()).to.equal('0');
  });
});
