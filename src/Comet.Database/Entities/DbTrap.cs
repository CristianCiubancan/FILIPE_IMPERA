﻿// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (C) FTW! Masters
// Keep the headers and the patterns adopted by the project. If you changed anything in the file just insert
// your name below, but don't remove the names of who worked here before.
// 
// This project is a fork from Comet, a Conquer Online Server Emulator created by Spirited, which can be
// found here: https://gitlab.com/spirited/comet
// 
// Comet - Comet.Game - DbTrap.cs
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

using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

#endregion

namespace Comet.Database.Entities
{
    [Table("cq_trap")]
    public class DbTrap
    {
        [Key] [Column("id")] public virtual uint Id { get; set; }
        [Column("type")] public virtual uint TypeId { get; set; }
        [Column("look")] public virtual uint Look { get; set; }
        [Column("owner_id")] public virtual uint OwnerId { get; set; }
        [Column("map_id")] public virtual uint MapId { get; set; }
        [Column("pos_x")] public virtual ushort PosX { get; set; }
        [Column("pos_y")] public virtual ushort PosY { get; set; }
        [Column("data")] public virtual uint Data { get; set; }

        public virtual DbTrapType Type { get; set; }


    }
}