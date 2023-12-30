// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (C) FTW! Masters
// Keep the headers and the patterns adopted by the project. If you changed anything in the file just insert
// your name below, but don't remove the names of who worked here before.
// 
// This project is a fork from Comet, a Conquer Online Server Emulator created by Spirited, which can be
// found here: https://gitlab.com/spirited/comet
// 
// Comet - Comet.Game - ActionRepository.cs
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

using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Comet.Database.Entities;
using Microsoft.EntityFrameworkCore;
namespace Comet.Game.Database.Repositories
{
    public static class TutorRepository
    {
        public static async Task<List<DbTutor>> GetAsync()
        {
            await using var db = new ServerDbContext();
            var tutors = await db.Tutor.ToListAsync();
            return tutors;
        }

        public static async Task<DbTutor> GetAsync(uint idStudent)
        {
            await using ServerDbContext ctx = new ServerDbContext();
            return await ctx.Tutor
                .Include(x => x.Guide)
                .Include(x => x.Student)
                .FirstOrDefaultAsync(x => x.StudentId == idStudent);
        }

        public static async Task<List<DbTutor>> GetStudentsAsync(uint idTutor)
        {
            await using ServerDbContext ctx = new ServerDbContext();
            return await ctx.Tutor
                .Include(x => x.Guide)
                .Include(x => x.Student)
                .Where(x => x.GuideId == idTutor)
                .ToListAsync();
        }
    }
}