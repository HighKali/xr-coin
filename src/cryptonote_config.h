#pragma once

namespace config
{
  const char CRYPTONOTE_NAME[] = "xr∞coin";
  const char TICKER[] = "$DSN";
  const char GENESIS_TX[] = "GENESIS_PLACEHOLDER";
  const uint64_t GENESIS_NONCE = 8888;

  const int P2P_DEFAULT_PORT = 17777;
  const int RPC_DEFAULT_PORT = 17778;
  const int ZMQ_RPC_DEFAULT_PORT = 17779;

  const uint64_t MONEY_SUPPLY = UINT64_C(88888888888888888);
  const unsigned EMISSION_SPEED_FACTOR = 18;
  const uint64_t MINIMUM_FEE = UINT64_C(88888);
  const uint64_t DEFAULT_DUST_THRESHOLD = UINT64_C(88888);

  const uint64_t DIFFICULTY_TARGET = 88;

  const char* const SEED_NODES[] = {
    "node.xr∞.org:17777",
    "orbit.xr∞.net:17777"
  };

  const char NETWORK_ID[] = { 'x', 'r', '∞', 'c', 'o', 'i', 'n' };
}
