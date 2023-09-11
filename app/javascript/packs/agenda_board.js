// 議題ボード詳細ページに表示されている主張と反論の見た目と挙動
jsPlumb.ready(function() {
  jsPlumb.setContainer("exchange_of_opinions");
  // 主張をドラッグ可能にし､リロード後も主張の位置が再現されるようにする + 主張のレイアウトを整える
  const all_arguments = document.querySelectorAll(".argument");
  all_arguments.forEach( function( argument ) {
    const argument_id = argument.getAttribute("id");

    // 主張をドラッグ可能(ドラッグハンドルは｢〇〇さんの主張｣部分を指定)にし､ドラッグ終了後の主張の位置をopinion_positionsテーブルに保存する
    jsPlumb.draggable(`${argument_id}`, {
      handle: '.argument_title',

      stop: function(event) {
        savePosition(argument_id, $(`#${argument_id}`).position());
      }
    });

    // opinion_positionsテーブルのデータを使用して､ページ読み込み時に主張の位置を復元する + 主張のレイアウトを整える + 主張ー反論間の接続線を復元する
    $.ajax({
      url: '/opinion_positions',
      method: 'GET',
      success: function(response) {
        const opinion_positions = response.opinion_positions;

        opinion_positions.forEach(function(position) {
          const argument_id_num = parseInt(argument_id.replace("argument", ""));
          if (position.argument_id === argument_id_num) {
            $(`#${argument_id}`).css({left: position.left + "px", top: position.top + "px"});
          }
        });
        // 遅延させないと理由証拠間のレイアウトが乱れる
        setTimeout(function() {
          arrangeArgumentLayout();
          restoreOpinionConnections();
        }, 10);
      },
      error: function(xhr, status, error) {
        console.error(xhr.responseJSON.error_message);
      }
    });

    // 主張のドラッグ終了後の位置をopinion_positionsテーブルに保存する関数
    function savePosition(argument_id, position) {
      const argument_id_num = parseInt(argument_id.replace("argument", ""));

      $.ajax({
        url: '/opinion_positions',
        method: 'POST',
        data: {
          opinion_position: {
            argument_id: argument_id_num,
            refutation_id: null,
            left: position.left,
            top: position.top
          }
        },
        success: function(response) {
          console.log(response.success_message)
        },
        error: function(xhr, status, error) {
          console.error(xhr.responseJSON.error_message);
        }
      });
    }

    // 主張の表示がツリー型になるよう接続線を引く + 主張内にターゲットエンドポイントを設置する関数
    function arrangeArgumentLayout() {
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
    }
  });

  // 反論をドラッグ可能にし､リロード後も反論の位置が再現されるようにする + 反論のレイアウトを整える
  jsPlumb.registerConnectionTypes({
    "red-connection": {
      paintStyle: {stroke: "red", strokeWidth: 5},
      hoverPaintStyle: {stroke: "red", strokeWidth: 10}
    }
  });

  const all_refutations = document.querySelectorAll(".refutation");
  all_refutations.forEach( function( refutation ) {
    const refutation_id = refutation.getAttribute("id");

    // 反論をドラッグ可能(ドラッグハンドルは｢〇〇さんの反論｣部分を指定｣)にし､ドラッグ終了後の反論の位置をopinion_positionsテーブルに保存する
    jsPlumb.draggable(`${refutation_id}`, {
      handle: '.refutation_title',

      stop: function(event) {
        savePosition(refutation_id, $(`#${refutation_id}`).position());
      }
    });

    // opinion_positionsテーブルのデータを使用して､ページ読み込み時に反論の位置を復元する + 反論のレイアウトを整える + 反論ー反論間の接続線を復元する
    $.ajax({
      url: '/opinion_positions',
      method: 'GET',
      success: function(response) {
        const opinion_positions = response.opinion_positions;

        opinion_positions.forEach(function(position) {
          const refutation_id_num = parseInt(refutation_id.replace("refutation", ""));
          if (position.refutation_id === refutation_id_num) {
            $(`#${refutation_id}`).css({left: position.left + "px", top: position.top + "px"});
          }
        });
        // 遅延させないとレイアウトが乱れる
        setTimeout(arrangeRefutationLayout, 10);
        setTimeout(setSourceEndpoint(refutation_id), 50);
        setTimeout(restoreOpinionConnections, 100);
      },
      error: function(xhr, status, error) {
        console.error(xhr.responseJSON.error_message);
      }
    });

    // 反論の左上にソースエンドポイントを設置する関数
    function setSourceEndpoint(refutation_id) {
      jsPlumb.addEndpoint(refutation_id, {
        endpoint: "Dot",
        anchor: "TopLeft",
        isSource: true,
        connectionType: "red-connection",
        paintStyle: { fill: "#456", radius: 10 },
        endpointHoverStyle: { fill: "red", radius: 15 }
      });
    }

    // 反論のドラッグ終了後の位置をopinion_positionsテーブルに保存する関数
    function savePosition(refutation_id, position) {
      const refutation_id_num = parseInt(refutation_id.replace("refutation", ""));

      $.ajax({
        url: '/opinion_positions',
        method: 'POST',
        data: {
          opinion_position: {
            argument_id: null,
            refutation_id: refutation_id_num,
            left: position.left,
            top: position.top
          }
        },
        success: function(response) {
          console.log(response.success_message)
        },
        error: function(xhr, status, error) {
          console.error(xhr.responseJSON.error_message);
        }
      });
    }

    // 反論の表示がツリー型になるよう接続線を引く + 反論内にターゲットエンドポイントを設置する関数
    function arrangeRefutationLayout() {
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
    }
  });

  // 意見間の接続線(赤色)が右クリックされたとき､｢削除ボタン｣を表示する
  jsPlumb.bind("contextmenu", function (component, event) {
    if (component.hasClass("jtk-connector") && component.sourceId.match(/refutation/)) {
      event.preventDefault();
      window.selectedConnection = component;
      $("<div class='custom-menu'><button class='delete-connection'>接続線を削除する</button></div>")
        .appendTo("body")
        .css({top: event.pageY + "px", left: event.pageX + "px"});
    }
  });
  // 削除ボタンが左クリックされたとき､意見間の接続線を削除する
  $("body").on("click", ".delete-connection", function(event) {
    jsPlumb.deleteConnection(window.selectedConnection);
    location.reload();
  });
  // 削除ボタンが左クリックされたとき､｢削除ボタン｣を削除する
  $(document).on("click", function(event) {
    $("div.custom-menu").remove();
  });

  // 意見間の接続線が追加されたり､接続先が変更された時､現在の接続線情報をopinion_connectionテーブルに保存する
  jsPlumb.bind("connection", function(info) {
    if (info.connection.sourceId.match(/refutation/)) {
      saveOpinionConnections(info.connection);
    }
  });

  // 新たな意見間の接続線が追加された時､リロードを実行する
  jsPlumb.bind("beforeDrop", function(info) {
      location.reload();
      return true;
  });

  // 意見間の接続線の接続先が変更された時､リロードを実行する
  jsPlumb.bind("connectionMoved", function(info){
    location.reload();
  });

  // 意見間の接続線が削除されたとき､その接続線の接続情報をopinion_connectionテーブルから削除する
  jsPlumb.bind("connectionDetached", function(info) {
    if (info.connection.sourceId.match(/refutation/)) {
      removeOpinionConnections(info.connection);
    }
  });

  // 意見間の接続線情報をopinion_connectionsテーブルに保存する関数
  function saveOpinionConnections(connection) {
    const sourceId = connection.sourceId;
    const targetId = connection.targetId;

    $.ajax({
      url: '/opinion_connections',
      method: 'POST',
      data: {
        opinion_connection: {
          source_id: sourceId,
          target_id: targetId
        }
      },
      success: function(response) {
        console.log(response.success_message);
      },
      error: function(xhr, status, error) {
        console.error(xhr.responseJSON.error_message);
      }
    });
  }

  //意見間の接続線情報をopinion_connectionsテーブルから削除する関数
  function removeOpinionConnections(connection) {
    const sourceId = connection.sourceId;
    const targetId = connection.targetId;

    $.ajax({
      url: '/opinion_connections/' + `${connection.id}`,
      method: 'DELETE',
      data: {
        opinion_connection: {
          source_id: sourceId,
          target_id: targetId
        }
      },
      success: function(response) {
        console.log(response.success_message);
      },
      error: function(xhr, status, error) {
        console.error(xhr.responseJSON.error_message);
      }
    });
  }

  // opinion_connectionsテーブルを元に､意見間の接続線を復元する関数
  function restoreOpinionConnections() {
    $.ajax({
      url: '/opinion_connections',
      method: 'GET',
      success: function(response) {
        const opinion_connections = response.opinion_connections;
        if (opinion_connections) {
          jsPlumb.batch(function() {
            opinion_connections.forEach(function(conn) {
              jsPlumb.connect({
                source: conn.source_id,
                target: conn.target_id,
                endpoint: "Dot",
                anchors: ["TopLeft", ["RightMiddle", "LeftMiddle"]],
                paintStyle: {stroke: "red", strokeWidth: 5},
                hoverPaintStyle: {stroke: "red", strokeWidth: 10},
                overlays:[
                  ["Arrow", {width: 20, length: 20}]
                ]
              });
            });
          });
        }
      },
      error: function(xhr, status, error) {
        console.error(xhr.responseJSON.error_message);
      }
    });
  }
});
