/*
 * == TYPE ==
 * 
 * ---
 *
 * match function
 * (url: URL, app: MatchOption) => boolean
 * 
 * ---
 *
 * MatchOption
 * {
 * 	opener: Opener
 * }
 *
 * ---
 *
 * Opener
 * {
 *   name: string;
 *   bundleId: string;
 *   path: string;
 * }
 * e.g)
 * {
 *   name: "Slack",
 *   bundleId: "com.tinyspeck.slackmacgap",
 *   path: "/Applications/Slack.app"
 * }
 *
 * ---
 *
 *  == TYPE END ==
 *
 */

export default {
  defaultBrowser: {
    name: "Google Chrome",
    profile: "개인",
  },
  handlers: [
    {
      match: (url) => url.hostname.includes("coupang"),
      browser: {
        name: "Google Chrome",
        profile: "개인",
      },
    },
    {
      match: (url) => url.hostname.includes("youtube"),
      browser: {
        name: "Google Chrome",
        profile: "개인",
      },
    },
    {
      match: (url) => url.hostname === "myezl.atlassian.net",
      browser: {
        name: "Google Chrome",
        profile: "이즐랩스",
      },
    },
    {
      match: (url) => url.hostname === "github.com" && url.pathname.startsWith("/ezllabs"),
      browser: {
        name: "Google Chrome",
        profile: "이즐랩스",
      },
    },
    {
      match: (url) => url.hostname.includes("www.figma.com"),
      browser: {
        name: "Google Chrome",
        profile: "이즐랩스",
      },
    },
    {
      match: (_url, app) => app.opener && app.opener.bundleId === "com.tinyspeck.slackmacgap",
      browser: {
        name: "Google Chrome",
        profile: "이즐랩스",
      },
    },
  ]
};

