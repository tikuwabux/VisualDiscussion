jsPlumb.ready(function() {
  arrangeOpinionLayout();

  window.addEventListener('resize', function() {
    jsPlumb.reset();
    arrangeOpinionLayout();
  });

  // 反論対象の意見の表示がツリー型になるよう接続線を引く + 反論対象の意見内にターゲットエンドポイントを設置する関数
  function arrangeOpinionLayout() {
    const rebuttal_target_argument_conclusion = document.getElementsByClassName('rebuttal_target_argument_conclusion')[0];
    if (rebuttal_target_argument_conclusion) {
      // 反論対象の主張の表示がツリー型になるよう接続線を引く + 反論対象の主張内にターゲットエンドポイントを設置する
      const conclusion_id = rebuttal_target_argument_conclusion.getAttribute("id");

        // 結論の左右中央にターゲットエンドポイントを設置する
        jsPlumb.addEndpoint(`${conclusion_id}`, {
          endpoint: "Dot",
          anchor: "RightMiddle",
          isTarget: true,
          connectionType: "red-connection",
          paintStyle: { fill: "#dbc1db", radius: 15 }
        })
        jsPlumb.addEndpoint(`${conclusion_id}`, {
          endpoint: "Dot",
          anchor: "LeftMiddle",
          isTarget: true,
          connectionType: "red-connection",
          paintStyle: { fill: "#dbc1db", radius: 15 }
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
            connectionType: "red-connection",
            paintStyle: { fill: "#dbc1db", radius: 15 }
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
            connectionType: "red-connection",
            paintStyle: { fill: "#dbc1db", radius: 15 }
          })
          jsPlumb.addEndpoint(`${reason_id}`, {
            endpoint: "Dot",
            anchor: "LeftMiddle",
            isTarget: true,
            connectionType: "red-connection",
            paintStyle: { fill: "#dbc1db", radius: 15 }
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
              connectionType: "red-connection",
              paintStyle: { fill: "#dbc1db", radius: 15 }
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
              connectionType: "red-connection",
              paintStyle: { fill: "#dbc1db", radius: 15 }
            })
            jsPlumb.addEndpoint(`${evidence_id}`, {
              endpoint: "Dot",
              anchor: "LeftMiddle",
              isTarget: true,
              connectionType: "red-connection",
              paintStyle: { fill: "#dbc1db", radius: 15 }
            })
          });
        });
    } else {
    //反論対象の反論の表示がツリー型になるよう接続線を引く + 反論対象の反論内にターゲットエンドポイントを設置する
    const rebuttal_target_refutation_conclusion = document.getElementsByClassName('rebuttal_target_refutation_conclusion')[0];
    const ref_conclusion_id = rebuttal_target_refutation_conclusion.getAttribute("id");

      // 結論の左右中央にターゲットエンドポイントを設置する
      jsPlumb.addEndpoint(`${ref_conclusion_id}`, {
        endpoint: "Dot",
        anchor: "RightMiddle",
        isTarget: true,
        connectionType: "red-connection",
        paintStyle: { fill: "#95c4d6", radius: 15 }
      })
      jsPlumb.addEndpoint(`${ref_conclusion_id}`, {
        endpoint: "Dot",
        anchor: "LeftMiddle",
        isTarget: true,
        connectionType: "red-connection",
        paintStyle: { fill: "#95c4d6", radius: 15 }
      })

      const ref_reasons_of_ref_conclusion = document.querySelectorAll(`.ref_reason_of_${ref_conclusion_id}`);
      ref_reasons_of_ref_conclusion.forEach( function( ref_reason ) {
        const ref_reason_id = ref_reason.getAttribute("id");

        // 結論 → endpoint 間に接続線を引く
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

        // endpointの真ん中にターゲットエンドポイントを設置する
        jsPlumb.addEndpoint(`endpoint_between_${ref_conclusion_id}_and_${ref_reason_id}`, {
          endpoint: "Dot",
          anchor: "Center",
          isTarget: true,
          connectionType: "red-connection",
          paintStyle: { fill: "#95c4d6", radius: 15 }
        })

        // endpoint → 理由 間に接続線を引く
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

        // 理由の左右中央にターゲットエンドポイントを設置する
        jsPlumb.addEndpoint(`${ref_reason_id}`, {
          endpoint: "Dot",
          anchor: "RightMiddle",
          isTarget: true,
          connectionType: "red-connection",
          paintStyle: { fill: "#95c4d6", radius: 15 }
        })
        jsPlumb.addEndpoint(`${ref_reason_id}`, {
          endpoint: "Dot",
          anchor: "LeftMiddle",
          isTarget: true,
          connectionType: "red-connection",
          paintStyle: { fill: "#95c4d6", radius: 15 }
        })

        const ref_evidences_of_ref_reason = document.querySelectorAll(`.ref_evidence_of_${ref_reason_id}`);
        ref_evidences_of_ref_reason.forEach( function( ref_evidence ) {
          const ref_evidence_id = ref_evidence.getAttribute("id");
          // 理由 → endpoint 間に接続線を引く
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

          // endpointの真ん中にターゲットエンドポイントを設置する
          jsPlumb.addEndpoint(`endpoint_between_${ref_reason_id}_and_${ref_evidence_id}`, {
            endpoint: "Dot",
            anchor: "Center",
            isTarget: true,
            connectionType: "red-connection",
            paintStyle: { fill: "#95c4d6", radius: 15 }
          })

          // endpoint → 証拠 間に接続線を引く
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

          // 証拠の左右中央にターゲットエンドポイントを設置する
          jsPlumb.addEndpoint(`${ref_evidence_id}`, {
            endpoint: "Dot",
            anchor: "RightMiddle",
            isTarget: true,
            connectionType: "red-connection",
            paintStyle: { fill: "#95c4d6", radius: 15 }
          })
          jsPlumb.addEndpoint(`${ref_evidence_id}`, {
            endpoint: "Dot",
            anchor: "LeftMiddle",
            isTarget: true,
            connectionType: "red-connection",
            paintStyle: { fill: "#95c4d6", radius: 15 }
          })
        });
      });
    }
  }
});
