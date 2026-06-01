const chrome = (profile) => ({
  name: "Google Chrome",
  profile,
});

export default {
  defaultBrowser: "Google Chrome",

  handlers: [
    {
      match: [
        "https://bilibili.com/*",
      ],
      browser: chrome("Default"),
    },
    {
      match: [
        "https://bytedance.larkoffice.com/*",
        "https://bytedance.sg.larkoffice.com/*",
        "https://bytetech.info/*",
      ],
      browser: chrome("Profile 1"),
    },
    {
      match: [
        "https://dcar.feishu.cn/*",
      ],
      browser: chrome("Profile 2"),
    },
  ],
};
