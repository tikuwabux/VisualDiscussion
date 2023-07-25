User.create!(
  [
    {
      name: "annie",
      email: 'annie@seed.com',
      password: 'annie000',
      password_confirmation: 'annie000'
    },
    {
      name: "brian",
      email: 'brian@seed.com',
      password: 'brian000',
      password_confirmation: 'brian000'
    }
  ]
)

AgendaBoard.create!(
  [
    {
      user_id: 1,
      agenda: '早起きは健康によいのか',
      category: '自然科学'
    },
    {
      user_id: 1,
      agenda: '何時に起きるのが一番健康的なのか',
      category: '自然科学'
    }
  ]
)

# annieの主張1(brianからの反論有り)
Conclusion.create!(
  agenda_board_id: 1,
  user_id: 1,
  conclusion_summary: '健康に悪い',
  conclusion_detail: '体だけではなく､心の健康にも悪い'
)

Reason.create!(
  [
    {
      conclusion_id: 1,
      reason_summary: '人間の体内時計の周期と実生活の行動周期のズレが大きくなるから',
      reason_detail: <<~DETAILS
        体内時計的に、最適な起床時間は青年期(15~30歳)で朝9時、
      壮年期・中年期(31~64歳)で朝8時、高年期(65歳以上で)朝7時。

        以上の時間より早起きすればするほど、
      体内時計の周期と生活の行動周期のズレが大きくなり、
      心身に悪影響を与える
      DETAILS
    },
    {
      conclusion_id: 1,
      reason_summary: '私が早起きを習慣にしていたとき､体調が悪かったから',
      reason_detail: <<~DETAILS
        高校生の時､毎日朝5時におきることを習慣化していたが、
      午前中は体調が悪く｡朝ごはんを食べる気力すらなかった｡
      DETAILS
    }
  ]
)

Evidence.create!(
  [
    {
      reason_id: 1,
      evidence_summary: '早起きは種々の生活習慣病のリスクを上げる',
      evidence_detail: <<~DETAILS
      https://gooday.nikkei.co.jp/atcl/
      report/14/091100031/111100171/?P=2
      DETAILS
    },
    {
      reason_id: 1,
      evidence_summary: '早起きはうつ病のリスクを上げる',
      evidence_detail: 'https://gendai.media/articles/-/45782?page=2'
    },
    {
      reason_id: 2,
      evidence_summary: '私の親の記憶',
      evidence_detail: '特になし'
    },
    {
      reason_id: 2,
      evidence_summary: '私の高校の友人の記憶',
      evidence_detail: '特になし'
    }
  ]
)

# annieの主張2(誰からの反論も無し)
Conclusion.create!(
  agenda_board_id: 1,
  user_id: 1,
  conclusion_summary: 'かなり健康に悪く拷問に等しい',
  conclusion_detail: '特になし'
)

Reason.create!(
  conclusion_id: 2,
  reason_summary: '早起きは様々な病気のリスクを上げることが明らかになっているから',
  reason_detail: '特になし'
)

Evidence.create!(
  reason_id: 3,
  evidence_summary: '早起きが､様々な病気のリスクを上げていることを示す研究データ',
  evidence_detail: '特になし'
)

# annieの主張1へのbrianの反論(annieからの反論有り)
RefConclusion.create!(
  agenda_board_id: 1,
  user_id: 2,
  conclusion_id: 1,
  ref_conclusion_summary: '提示された､｢体内時計的に最適な起床時間｣は誤りである｡',
  ref_conclusion_detail: '体内時計は同年齢間においても個人差があり､一律ではないから'
)

RefReason.create!(
  ref_conclusion_id: 1,
  ref_reason_summary: '体内時計は同年齢間においても個人差があり､一律ではないから',
  ref_reason_detail: <<~DETAILS
    0時過ぎに寝て8時頃に起きるのが自然のリズムである人が最も多く、
  一方で、1:30以降に寝て9:30以降に起きるような夜型の人や、
  逆に22:30頃前に寝て6:30以前に自然に起きるような朝型の人もいる｡
  DETAILS
)

RefEvidence.create!(
  ref_reason_id: 1,
  ref_evidence_summary: '8155名のMSFsc調査結果',
  ref_evidence_detail: 'https://team.tokyo-med.ac.jp/omh/news/202203_chronotype/'
)

# brianの反論へのannieの反論(誰からの反論も無し)
RefConclusion.create!(
  agenda_board_id: 1,
  user_id: 1,
  parent_ref_conclusion_id: 1,
  ref_conclusion_summary: '証拠と理由が繋がっていない',
  ref_conclusion_detail: '特になし'
)

RefReason.create!(
  ref_conclusion_id: 2,
  ref_reason_summary: '証拠にあげている調査は､同年齢を対象としたものではないから',
  ref_reason_detail: <<~DETAILS
    提示された調査は､様々な年齢の人々(平均年齢は36.7歳)
  を対象にしたものなので､｢体内時計は同年齢間においても個人差がある｣
  ということの証拠として適当ではない
  DETAILS
)

RefEvidence.create!(
  ref_reason_id: 2,
  ref_evidence_summary: '論理性の話であるため､必要なし',
  ref_evidence_detail: '特になし'
)

OpinionPosition.create!(
  [
    {
      argument_id: 1,
      left: 130,
      top: 180
    },
    {
      refutation_id: 1,
      left: 130,
      top: 1200
    },
    {
      refutation_id: 2,
      left: 900,
      top: 1200
    },
    {
      argument_id: 2,
      left: 1500,
      top: 180
    }
  ]
)

OpinionConnection.create!(
  [
    {
      source_id: 'refutation1',
      target_id: 'reason0_of_conclusion1'
    },
    {
      source_id: 'refutation2',
      target_id: 'endpoint_between_ref_reason0_of_ref_conclusion1_and_ref_evidence0_of_ref_reason0_of_ref_conclusion1'
    }
  ]
)
