// 議題ボード詳細ページに表示されている主張と反論の見た目と挙動
jsPlumb.ready(function() {
  jsPlumb.setContainer("exchange_of_opinions");
  // 主張をドラッグ可能にし､リロード後も主張の位置が再現されるようにする
  const all_arguments = document.querySelectorAll(".argument");
  all_arguments.forEach( function( argument ) {
    const argument_id = argument.getAttribute("id");

    // 主張をドラッグ可能にする
    jsPlumb.draggable(`${argument_id}`, {
      stop: function(event) {
        savePositions();
      }
    });

    // 主張のドラッグ終了後の位置をローカルストレージに保存する関数
    function savePositions() {
      localStorage.setItem(`${argument_id}_position`, JSON.stringify($(`#${argument_id}`).position()));
    }

    // ローカルストレージに保存された主張の位置を復元する
    const argument_position = JSON.parse(localStorage.getItem(`${argument_id}_position`));
    if (argument_position) {
      $(`#${argument_id}`).css({left: argument_position.left + "px", top: argument_position.top + "px"});
    }
  });

  // 反論をドラッグ可能にし､リロード後も反論の位置が再現されるようにする + 反論の左上にソースエンドポイントを設置する
  jsPlumb.registerConnectionTypes({
    "red-connection": {
      paintStyle: {stroke: "red", strokeWidth: 5},
      hoverPaintStyle: {stroke: "red", strokeWidth: 10}
    }
  });

  const all_refutations = document.querySelectorAll(".refutation");
  all_refutations.forEach( function( refutation ) {
    const refutation_id = refutation.getAttribute("id");

    jsPlumb.draggable(`${refutation_id}`, {
      stop: function(event) {
        savePositions();
      }
    });

    function savePositions() {
      localStorage.setItem(`${refutation_id}_position`, JSON.stringify($(`#${refutation_id}`).position()));
    }

    const refutation_position = JSON.parse(localStorage.getItem(`${refutation_id}_position`));
    if (refutation_position) {
      $(`#${refutation_id}`).css({left: refutation_position.left + "px", top: refutation_position.top + "px"});
    }

    // 反論の左上にソースエンドポイントを設置する
    jsPlumb.addEndpoint(`${refutation_id}`, {
      endpoint: "Dot",
      anchor: "TopLeft",
      isSource: true,
      connectionType: "red-connection"
    })
  });

  // 主張の表示がツリー型になるよう接続線を引く + 主張内にターゲットエンドポイントを設置する
  const conclusions = document.querySelectorAll(".conclusion");
  conclusions.forEach( function( conclusion ) {
    const conclusion_id = conclusion.getAttribute("id");

    // 結論の左右中央にターゲットエンドポイントを設置する
    jsPlumb.addEndpoint(`${conclusion_id}`, {
      endpoint: "Dot",
      anchor: "RightMiddle",
      isTarget: true,
      connectionType: "red-connection"
    })
    jsPlumb.addEndpoint(`${conclusion_id}`, {
      endpoint: "Dot",
      anchor: "LeftMiddle",
      isTarget: true,
      connectionType: "red-connection"
    })

    const reasons_of_conclusion = document.querySelectorAll(`.reason_of_${conclusion_id}`);
    reasons_of_conclusion.forEach( function( reason ) {
      const reason_id = reason.getAttribute("id");

      // 結論 → endpoint 間に接続線を引く
      jsPlumb.connect({
        source: `${conclusion_id}`,
        target: `endpoint_between_${conclusion_id}_and_${reason_id}`,
        anchors: ["Bottom", "Top"],
        connector: "Straight",
        endpoint:"Blank",
        overlays:[
          ["Arrow", {width: 10, length: 10}]
        ]
      });

      // endpointの真ん中にターゲットエンドポイントを設置する
      jsPlumb.addEndpoint(`endpoint_between_${conclusion_id}_and_${reason_id}`, {
        endpoint: "Dot",
        anchor: "Center",
        isTarget: true,
        connectionType: "red-connection"
      })

      // endpoint → 理由 間に接続線を引く
      jsPlumb.connect({
        source: `endpoint_between_${conclusion_id}_and_${reason_id}`,
        target: `${reason_id}`,
        anchors: ["Bottom", "Top"],
        connector: "Straight",
        endpoint:"Blank",
        overlays:[
          ["Arrow", {width: 10, length: 10}]
        ]
      });

      // 理由の左右中央にターゲットエンドポイントを設置する
      jsPlumb.addEndpoint(`${reason_id}`, {
        endpoint: "Dot",
        anchor: "RightMiddle",
        isTarget: true,
        connectionType: "red-connection"
      })
      jsPlumb.addEndpoint(`${reason_id}`, {
        endpoint: "Dot",
        anchor: "LeftMiddle",
        isTarget: true,
        connectionType: "red-connection"
      })

      const evidences_of_reason = document.querySelectorAll(`.evidence_of_${reason_id}`);
      evidences_of_reason.forEach( function( evidence ) {
        const evidence_id = evidence.getAttribute("id");
        // 理由 → endpoint 間に接続線を引く
        jsPlumb.connect({
          source: `${reason_id}`,
          target: `endpoint_between_${reason_id}_and_${evidence_id}`,
          anchors: ["Bottom", "Top"],
          connector: "Straight",
          endpoint:"Blank",
          overlays:[
            ["Arrow", {width: 10, length: 10}]
          ]
        });

        // endpointの真ん中にターゲットエンドポイントを設置する
        jsPlumb.addEndpoint(`endpoint_between_${reason_id}_and_${evidence_id}`, {
          endpoint: "Dot",
          anchor: "Center",
          isTarget: true,
          connectionType: "red-connection"
        })

        // endpoint → 証拠 間に接続線を引く
        jsPlumb.connect({
          source: `endpoint_between_${reason_id}_and_${evidence_id}`,
          target: `${evidence_id}`,
          anchors: ["Bottom", "Top"],
          connector: "Straight",
          endpoint:"Blank",
          overlays:[
            ["Arrow", {width: 10, length: 10}]
          ]
        });

        // 証拠の左右中央にターゲットエンドポイントを設置する
        jsPlumb.addEndpoint(`${evidence_id}`, {
          endpoint: "Dot",
          anchor: "RightMiddle",
          isTarget: true,
          connectionType: "red-connection"
        })
        jsPlumb.addEndpoint(`${evidence_id}`, {
          endpoint: "Dot",
          anchor: "LeftMiddle",
          isTarget: true,
          connectionType: "red-connection"
        })
      });
    });
  });

  // 反論(サンプル)の表示がツリー型になるよう接続線を引く + 反論内にターゲットエンドポイントを設置する
  const ref_conclusions = document.querySelectorAll(".ref_conclusion");
  ref_conclusions.forEach( function( ref_conclusion ) {
    const ref_conclusion_id = ref_conclusion.getAttribute("id");

    jsPlumb.addEndpoint(`${ref_conclusion_id}`, {
      endpoint: "Dot",
      anchor: "RightMiddle",
      isTarget: true,
      connectionType: "red-connection"
    })
    jsPlumb.addEndpoint(`${ref_conclusion_id}`, {
      endpoint: "Dot",
      anchor: "LeftMiddle",
      isTarget: true,
      connectionType: "red-connection"
    })

    const ref_reasons_of_ref_conclusion = document.querySelectorAll(`.ref_reason_of_${ref_conclusion_id}`);
    ref_reasons_of_ref_conclusion.forEach( function( ref_reason ) {
      const ref_reason_id = ref_reason.getAttribute("id");

      jsPlumb.connect({
        source: `${ref_conclusion_id}`,
        target: `endpoint_between_${ref_conclusion_id}_and_${ref_reason_id}`,
        anchors: ["Bottom", "Top"],
        connector: "Straight",
        endpoint:"Blank",
        overlays:[
          ["Arrow", {width: 10, length: 10}]
        ]
      });

      jsPlumb.addEndpoint(`endpoint_between_${ref_conclusion_id}_and_${ref_reason_id}`, {
        endpoint: "Dot",
        anchor: "Center",
        isTarget: true,
        connectionType: "red-connection",
      })

      jsPlumb.connect({
        source: `endpoint_between_${ref_conclusion_id}_and_${ref_reason_id}`,
        target: `${ref_reason_id}`,
        anchors: ["Bottom", "Top"],
        connector: "Straight",
        endpoint:"Blank",
        overlays:[
          ["Arrow", {width: 10, length: 10}]
        ]
      });

      jsPlumb.addEndpoint(`${ref_reason_id}`, {
        endpoint: "Dot",
        anchor: "RightMiddle",
        isTarget: true,
        connectionType: "red-connection"
      })
      jsPlumb.addEndpoint(`${ref_reason_id}`, {
        endpoint: "Dot",
        anchor: "LeftMiddle",
        isTarget: true,
        connectionType: "red-connection"
      })

      const ref_evidences_of_ref_reason = document.querySelectorAll(`.ref_evidence_of_${ref_reason_id}`);

      ref_evidences_of_ref_reason.forEach( function( ref_evidence ) {
        const ref_evidence_id = ref_evidence.getAttribute("id");

        jsPlumb.connect({
          source: `${ref_reason_id}`,
          target: `endpoint_between_${ref_reason_id}_and_${ref_evidence_id}`,
          anchors: ["Bottom", "Top"],
          connector: "Straight",
          endpoint:"Blank",
          overlays:[
            ["Arrow", {width: 10, length: 10}]
          ]
        });

        jsPlumb.addEndpoint(`endpoint_between_${ref_reason_id}_and_${ref_evidence_id}`, {
          endpoint: "Dot",
          anchor: "Center",
          isTarget: true,
          connectionType: "red-connection"
        })

        jsPlumb.connect({
          source: `endpoint_between_${ref_reason_id}_and_${ref_evidence_id}`,
          target: `${ref_evidence_id}`,
          anchors: ["Bottom", "Top"],
          connector: "Straight",
          endpoint:"Blank",
          overlays:[
            ["Arrow", {width: 10, length: 10}]
          ]
        });

        jsPlumb.addEndpoint(`${ref_evidence_id}`, {
          endpoint: "Dot",
          anchor: "RightMiddle",
          isTarget: true,
          connectionType: "red-connection"
        })
        jsPlumb.addEndpoint(`${ref_evidence_id}`, {
          endpoint: "Dot",
          anchor: "LeftMiddle",
          isTarget: true,
          connectionType: "red-connection"
        })
      });
    });
  });

  // 接続線が右クリックされたとき､｢削除ボタン｣を表示する
  jsPlumb.bind("contextmenu", function (component, event) {
    if (component.hasClass("jtk-connector")) {
      event.preventDefault();
      window.selectedConnection = component;
      $("<div class='custom-menu'><button class='delete-connection'>Delete connection</button></div>")
        .appendTo("body")
        .css({top: event.pageY + "px", left: event.pageX + "px"});
    }
  });
  // 削除ボタンが左クリックされたとき､接続線を削除する
  $("body").on("click", ".delete-connection", function(event) {
    jsPlumb.deleteConnection(window.selectedConnection);
    saveConnections();
  });
  // 削除ボタンが左クリックされたとき､｢削除ボタン｣を削除する
  $(document).on("click", function(event) {
    $("div.custom-menu").remove();
  });

  // 接続が追加/削除された時に接続情報をローカルストレージに保存する
  jsPlumb.bind("connection", function(info) {
    saveConnections();
  });
  jsPlumb.bind("connectionDetached", function(info) {
    if (!info.connection.endpoints[0].isTemporarySourceEndpoint && !info.connection.endpoints[1].isTemporaryTargetEndpoint) {
      removeConnection(info.connection);
      if (info.connection && !info.connection.isDetached()) {
        saveConnections();
      }
    }
  });

  // ページリロード前に接続があった場合､ページリロード後に接続を復元する
  // (ソースエンドポイントが反論である赤色の接続線のみを復元の対象とし､主張内･反論内の黒色の接続線は対象外とする)
  var connections = JSON.parse(localStorage.getItem("connections"));
  if (connections) {
    jsPlumb.batch(function() {
      connections.forEach(function(conn) {
        if (conn.sourceId.match(/refutation/)) {
          jsPlumb.connect({
            source: conn.sourceId,
            target: conn.targetId,
            endpoint: "Dot",
            anchors: ["TopLeft", ["RightMiddle", "LeftMiddle"]],
            paintStyle: {stroke: "red", strokeWidth: 5},
            hoverPaintStyle: {stroke: "red", strokeWidth: 10},
            uuids: [conn.sourceEndpointId, conn.targetEndpointId],
            overlays:[
              ["Arrow", {width: 20, length: 20}]
            ]
          });
        }
      });
    });
  }

  // 接続情報をローカルストレージに保存する関数
  function saveConnections() {
    var connections = [];
    jsPlumb.getAllConnections().forEach(function(conn) {
      if (!conn.isDetached) {
        connections.push({
          sourceId: conn.sourceId,
          targetId: conn.targetId,
          sourceEndpointId: conn.endpoints[0].getUuid(),
          targetEndpointId: conn.endpoints[1].getUuid()
        });
      }
    });
    localStorage.setItem("connections", JSON.stringify(connections));
  }

  // 接続情報をローカルストレージから削除する関数
  function removeConnection(connection) {
    var connections = JSON.parse(localStorage.getItem("connections"));
    if (connections) {
      connections = connections.filter(function(conn) {
        return conn.sourceId !== connection.sourceId || conn.targetId !== connection.targetId;
      });
      if (!connection.isDetached()) {
        localStorage.setItem("connections", JSON.stringify(connections));
      }
    }
  }
});