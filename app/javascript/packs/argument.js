jsPlumb.ready(function() {
  // 主張の表示がツリー型になるよう接続線を引く
  const conclusions = document.querySelectorAll(".conclusion");

  conclusions.forEach( function( conclusion ) {
    const conclusion_id = conclusion.getAttribute("id");
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
      });
    });
  });

  // 反論(サンプル)の表示がツリー型になるよう接続線を引く
  const ref_conclusions = document.querySelectorAll(".ref_conclusion");

  jsPlumb.registerConnectionTypes({
    "red-connection": {
      paintStyle: {stroke: "red", strokeWidth: 5},
      hoverPaintStyle: {stroke: "red", strokeWidth: 10}
    }
  });

  ref_conclusions.forEach( function( ref_conclusion ) {
    const ref_conclusion_id = ref_conclusion.getAttribute("id");
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
      });
    });
  });
});
