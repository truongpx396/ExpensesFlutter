enum ExpenseStatusEnum {
  Draft,
  PendingOnATeamValidation,
  RefusedByAFM,
  RefusedByATeam,
  RefusedByManager,
  PendingOnManagerValidation,
  ValidatedByManager,
  Refused,
  UncompliantDraft,
  PendingOnCompliance,
}

const Map<ExpenseStatusEnum, String> ExpenseStatusName = {
  ExpenseStatusEnum.Draft: "Draft",
  ExpenseStatusEnum.PendingOnATeamValidation: "PendingOnATeamValidation",
  ExpenseStatusEnum.RefusedByAFM: "RefusedByAFM",
  ExpenseStatusEnum.RefusedByATeam: "RefusedByATeam",
  ExpenseStatusEnum.RefusedByManager: "RefusedByManager",
  ExpenseStatusEnum.PendingOnManagerValidation: "PendingOnManagerValidation",
  ExpenseStatusEnum.ValidatedByManager: "ValidatedByManager",
  ExpenseStatusEnum.Refused: "Refused",
  ExpenseStatusEnum.UncompliantDraft: "UncompliantDraft",
  ExpenseStatusEnum.PendingOnCompliance: "PendingOnCompliance",
};
