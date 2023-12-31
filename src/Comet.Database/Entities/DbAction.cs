﻿// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (C) FTW! Masters
// Keep the headers and the patterns adopted by the project. If you changed anything in the file just insert
// your name below, but don't remove the names of who worked here before.
// 
// This project is a fork from Comet, a Conquer Online Server Emulator created by Spirited, which can be
// found here: https://gitlab.com/spirited/comet
// 
// Comet - Comet.Game - DbAction.cs
// Description:
// 
// Creator: FELIPEVIEIRAVENDRAMI [FELIPE VIEIRA VENDRAMINI]
// 
// Developed by:
// Felipe Vieira Vendramini <felipevendramini@live.com>
// 
// Programming today is a race between software engineers striving to build bigger and better
// idiot-proof programs, and the Universe trying to produce bigger and better idiots.
// So far, the Universe is winning.
// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#region References

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

#endregion

namespace Comet.Database.Entities
{
    [Table("cq_action")]
    public class DbAction
    {
        [Key] [Column("id")] public virtual uint Identity { get; set; }
        [Column("id_next")] public virtual uint IdNext { get; set; }
        [Column("id_nextfail")] public virtual uint IdNextfail { get; set; }
        [Column("type")] public virtual uint Type { get; set; }
        [Column("data")] public virtual uint Data { get; set; }
        [Column("param")] public virtual string Param { get; set; }
    }
}