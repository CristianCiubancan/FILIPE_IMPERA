﻿// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (C) FTW! Masters
// Keep the headers and the patterns adopted by the project. If you changed anything in the file just insert
// your name below, but don't remove the names of who worked here before.
// 
// This project is a fork from Comet, a Conquer Online Server Emulator created by Spirited, which can be
// found here: https://gitlab.com/spirited/comet
// 
// Comet - Comet.Game - SyndicateEnemyRepository.cs
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
using System.Linq;
using System.Threading.Tasks;
using Comet.Database.Entities;
using Microsoft.EntityFrameworkCore;

#endregion

namespace Comet.Game.Database.Repositories
{
    public static class SyndicateEnemyRepository
    {
        public static async Task<List<DbSyndicateEnemy>> GetAsync(uint id)
        {
            await using var db = new ServerDbContext();
            return await db.SyndicatesEnemy.Where(x => x.SyndicateIdentity == id).ToListAsync();
        }

        public static async Task<bool> DeleteAsync(uint id0, uint id1)
        {
            DbSyndicateEnemy enemy = (await GetAsync(id0)).FirstOrDefault(x => x.EnemyIdentity == id1);
            return enemy != null && await BaseRepository.DeleteAsync(enemy);
        }
    }
}