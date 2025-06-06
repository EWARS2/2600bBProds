/* taken from Stella (Console.cxx) */
static const uint32_t ntsc_palette[256] = {
  0x000000, 0, 0x4a4a4a, 0, 0x6f6f6f, 0, 0x8e8e8e, 0,
  0xaaaaaa, 0, 0xc0c0c0, 0, 0xd6d6d6, 0, 0xececec, 0,
  0x484800, 0, 0x69690f, 0, 0x86861d, 0, 0xa2a22a, 0,
  0xbbbb35, 0, 0xd2d240, 0, 0xe8e84a, 0, 0xfcfc54, 0,
  0x7c2c00, 0, 0x904811, 0, 0xa26221, 0, 0xb47a30, 0,
  0xc3903d, 0, 0xd2a44a, 0, 0xdfb755, 0, 0xecc860, 0,
  0x901c00, 0, 0xa33915, 0, 0xb55328, 0, 0xc66c3a, 0,
  0xd5824a, 0, 0xe39759, 0, 0xf0aa67, 0, 0xfcbc74, 0,
  0x940000, 0, 0xa71a1a, 0, 0xb83232, 0, 0xc84848, 0,
  0xd65c5c, 0, 0xe46f6f, 0, 0xf08080, 0, 0xfc9090, 0,
  0x840064, 0, 0x97197a, 0, 0xa8308f, 0, 0xb846a2, 0,
  0xc659b3, 0, 0xd46cc3, 0, 0xe07cd2, 0, 0xec8ce0, 0,
  0x500084, 0, 0x68199a, 0, 0x7d30ad, 0, 0x9246c0, 0,
  0xa459d0, 0, 0xb56ce0, 0, 0xc57cee, 0, 0xd48cfc, 0,
  0x140090, 0, 0x331aa3, 0, 0x4e32b5, 0, 0x6848c6, 0,
  0x7f5cd5, 0, 0x956fe3, 0, 0xa980f0, 0, 0xbc90fc, 0,
  0x000094, 0, 0x181aa7, 0, 0x2d32b8, 0, 0x4248c8, 0,
  0x545cd6, 0, 0x656fe4, 0, 0x7580f0, 0, 0x8490fc, 0,
  0x001c88, 0, 0x183b9d, 0, 0x2d57b0, 0, 0x4272c2, 0,
  0x548ad2, 0, 0x65a0e1, 0, 0x75b5ef, 0, 0x84c8fc, 0,
  0x003064, 0, 0x185080, 0, 0x2d6d98, 0, 0x4288b0, 0,
  0x54a0c5, 0, 0x65b7d9, 0, 0x75cceb, 0, 0x84e0fc, 0,
  0x004030, 0, 0x18624e, 0, 0x2d8169, 0, 0x429e82, 0,
  0x54b899, 0, 0x65d1ae, 0, 0x75e7c2, 0, 0x84fcd4, 0,
  0x004400, 0, 0x1a661a, 0, 0x328432, 0, 0x48a048, 0,
  0x5cba5c, 0, 0x6fd26f, 0, 0x80e880, 0, 0x90fc90, 0,
  0x143c00, 0, 0x355f18, 0, 0x527e2d, 0, 0x6e9c42, 0,
  0x87b754, 0, 0x9ed065, 0, 0xb4e775, 0, 0xc8fc84, 0,
  0x303800, 0, 0x505916, 0, 0x6d762b, 0, 0x88923e, 0,
  0xa0ab4f, 0, 0xb7c25f, 0, 0xccd86e, 0, 0xe0ec7c, 0,
  0x482c00, 0, 0x694d14, 0, 0x866a26, 0, 0xa28638, 0,
  0xbb9f47, 0, 0xd2b656, 0, 0xe8cc63, 0, 0xfce070, 0
};

static const uint32_t pal_palette[256] = {
  0x000000, 0, 0x2b2b2b, 0, 0x525252, 0, 0x767676, 0,
  0x979797, 0, 0xb6b6b6, 0, 0xd2d2d2, 0, 0xececec, 0,
  0x000000, 0, 0x2b2b2b, 0, 0x525252, 0, 0x767676, 0,
  0x979797, 0, 0xb6b6b6, 0, 0xd2d2d2, 0, 0xececec, 0,
  0x805800, 0, 0x96711a, 0, 0xab8732, 0, 0xbe9c48, 0,
  0xcfaf5c, 0, 0xdfc06f, 0, 0xeed180, 0, 0xfce090, 0,
  0x445c00, 0, 0x5e791a, 0, 0x769332, 0, 0x8cac48, 0,
  0xa0c25c, 0, 0xb3d76f, 0, 0xc4ea80, 0, 0xd4fc90, 0,
  0x703400, 0, 0x89511a, 0, 0xa06b32, 0, 0xb68448, 0,
  0xc99a5c, 0, 0xdcaf6f, 0, 0xecc280, 0, 0xfcd490, 0,
  0x006414, 0, 0x1a8035, 0, 0x329852, 0, 0x48b06e, 0,
  0x5cc587, 0, 0x6fd99e, 0, 0x80ebb4, 0, 0x90fcc8, 0,
  0x700014, 0, 0x891a35, 0, 0xa03252, 0, 0xb6486e, 0,
  0xc95c87, 0, 0xdc6f9e, 0, 0xec80b4, 0, 0xfc90c8, 0,
  0x005c5c, 0, 0x1a7676, 0, 0x328e8e, 0, 0x48a4a4, 0,
  0x5cb8b8, 0, 0x6fcbcb, 0, 0x80dcdc, 0, 0x90ecec, 0,
  0x70005c, 0, 0x841a74, 0, 0x963289, 0, 0xa8489e, 0,
  0xb75cb0, 0, 0xc66fc1, 0, 0xd380d1, 0, 0xe090e0, 0,
  0x003c70, 0, 0x195a89, 0, 0x2f75a0, 0, 0x448eb6, 0,
  0x57a5c9, 0, 0x68badc, 0, 0x79ceec, 0, 0x88e0fc, 0,
  0x580070, 0, 0x6e1a89, 0, 0x8332a0, 0, 0x9648b6, 0,
  0xa75cc9, 0, 0xb76fdc, 0, 0xc680ec, 0, 0xd490fc, 0,
  0x002070, 0, 0x193f89, 0, 0x2f5aa0, 0, 0x4474b6, 0,
  0x578bc9, 0, 0x68a1dc, 0, 0x79b5ec, 0, 0x88c8fc, 0,
  0x340080, 0, 0x4a1a96, 0, 0x5f32ab, 0, 0x7248be, 0,
  0x835ccf, 0, 0x936fdf, 0, 0xa280ee, 0, 0xb090fc, 0,
  0x000088, 0, 0x1a1a9d, 0, 0x3232b0, 0, 0x4848c2, 0,
  0x5c5cd2, 0, 0x6f6fe1, 0, 0x8080ef, 0, 0x9090fc, 0,
  0x000000, 0, 0x2b2b2b, 0, 0x525252, 0, 0x767676, 0,
  0x979797, 0, 0xb6b6b6, 0, 0xd2d2d2, 0, 0xececec, 0,
  0x000000, 0, 0x2b2b2b, 0, 0x525252, 0, 0x767676, 0,
  0x979797, 0, 0xb6b6b6, 0, 0xd2d2d2, 0, 0xececec, 0
};
