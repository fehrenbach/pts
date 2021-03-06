module PTS.Syntax.Statement
  ( Stmt (..)
  ) where

import PTS.Error (Position)
import PTS.Syntax.Names (Name, ModuleName)
import PTS.Syntax.Term (Term)

data Stmt
  = Bind Name [([Name], Term)] (Maybe Term) Term
  | Term Term
  | Export Name
  | Import ModuleName
  | StmtPos Position Stmt
  | Assertion Term (Maybe Term) (Maybe Term)
