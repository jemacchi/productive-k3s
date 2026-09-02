function initializePlaybookCasts() {
  var nodes = document.querySelectorAll(".pk3s-playbook-cast[data-cast-src]");
  if (!nodes.length) {
    return;
  }

  function resolvePlayerApi() {
    return (
      (typeof globalThis !== "undefined" && globalThis.AsciinemaPlayer) ||
      (typeof window !== "undefined" && window.AsciinemaPlayer) ||
      (typeof AsciinemaPlayer !== "undefined" ? AsciinemaPlayer : null)
    );
  }

  function initNode(node, attempts) {
    var playerApi = resolvePlayerApi();
    var playerRoot = node.querySelector(".pk3s-playbook-cast__player");
    var fallback = node.querySelector(".pk3s-playbook-cast__fallback");
    if (!playerRoot) {
      if (fallback) {
        fallback.hidden = false;
      }
      return;
    }
    if (!playerApi) {
      if (attempts > 40) {
        if (fallback) {
          fallback.hidden = false;
        }
        return;
      }
      window.setTimeout(function () {
        initNode(node, attempts + 1);
      }, 100);
      return;
    }
    try {
      playerApi.create(node.dataset.castSrc, playerRoot, {
        autoPlay: false,
        preload: true,
        fit: "width",
        controls: true
      });
      if (fallback) {
        fallback.hidden = true;
      }
    } catch (error) {
      console.error("Failed to initialize playbook cast", error);
      if (fallback) {
        fallback.hidden = false;
      }
    }
  }

  nodes.forEach(function (node) {
    initNode(node, 0);
  });
}

if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", initializePlaybookCasts);
} else {
  initializePlaybookCasts();
}
