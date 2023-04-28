const conclusions = document.querySelectorAll(".conclusion");
conclusions.forEach( function( conclusion, conclusion_i ) {
  const endpoints_between_conclusion_and_reason = document.querySelectorAll(`.endpoint_between_conclusion${conclusion_i}_and_reason`);
  const reasons_of_conclusion = document.querySelectorAll(`.reason_of_conclusion${conclusion_i}`);

  reasons_of_conclusion.forEach( function( reason, reason_i ) {
    new LeaderLine(conclusion, endpoints_between_conclusion_and_reason[reason_i], {startSocket: "bottom", endSocket: "top", path: "straight"});
    new LeaderLine(endpoints_between_conclusion_and_reason[reason_i], reason, {startSocket: "bottom", endSocket: "top", path: "straight"});
    const endpoints_between_reason_of_conclusion_and_evidence = document.querySelectorAll(`.endpoint_between_reason${reason_i}_of_conclusion${conclusion_i}_and_evidence`);
    const evidences_of_reason_of_conclusion = document.querySelectorAll(`.evidence_of_reason${reason_i}_of_conclusion${conclusion_i}`);

    evidences_of_reason_of_conclusion.forEach( function( evidence, evidence_i ) {
      new LeaderLine(reason, endpoints_between_reason_of_conclusion_and_evidence[evidence_i], {startSocket: "bottom", endSocket: "top", path: "straight"});
      new LeaderLine(endpoints_between_reason_of_conclusion_and_evidence[evidence_i], evidence, {startSocket: "bottom", endSocket: "top", path: "straight"});
    });
  });
});
