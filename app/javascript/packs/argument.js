// 主張の表示がツリー型になるよう線を引く
jsPlumb.ready(function() {
  const conclusions = document.querySelectorAll(".conclusion");

  conclusions.forEach( function( conclusion ) {
    const conclusion_id = conclusion.getAttribute("id");
    const reasons_of_conclusion = document.querySelectorAll(`.reason_of_${conclusion_id}`);

    reasons_of_conclusion.forEach( function( reason ) {
      const reason_id = reason.getAttribute("id");
      // 結論 → endponit
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
      // endponit → 理由
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
        // 理由 → endpoint
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
        // endpoint → 証拠
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
});
