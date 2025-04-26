import { Rhum } from "https://deno.land/x/rhum@v1.1.11/mod.ts";

import * as utils from "./utils.ts";

Rhum.testPlan("utils", () => {
  Rhum.testSuite(".isWin()", () => {
    Rhum.testCase("returns true if os is windows", () => {
      Rhum.asserts.assertEquals(utils.isWin("windows"), true);
    });
    Rhum.testCase("returns false otherwise", () => {
      Rhum.asserts.assertEquals(utils.isWin("linux"), false);
      Rhum.asserts.assertEquals(utils.isWin("darwin"), false);
    });
  });

  Rhum.testSuite(".homeDirectoryEnv()", () => {
    Rhum.testCase("returns USERPROFILE if os is windows", () => {
      Rhum.asserts.assertEquals(
        utils.homeDirectoryEnv("windows"),
        "USERPROFILE",
      );
    });
    Rhum.testCase("returns HOME otherwise", () => {
      Rhum.asserts.assertEquals(utils.homeDirectoryEnv("linux"), "HOME");
      Rhum.asserts.assertEquals(utils.homeDirectoryEnv("darwin"), "HOME");
    });
  });
});

Rhum.run();
