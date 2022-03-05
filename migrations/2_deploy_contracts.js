const Medifi = artifacts.require("Medifi");

module.exports = function (deployer) {
  deployer.deploy(Medifi);
};