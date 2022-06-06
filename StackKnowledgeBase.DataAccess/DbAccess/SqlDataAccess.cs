﻿using Dapper;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StackKnowledgeBase.DataAccess.DbAccess;

public class SqlDataAccess : ISqlDataAccess
{
    private readonly IConfiguration _config;

    public SqlDataAccess(IConfiguration config)
    {
        _config = config;
    }

    public async Task<IEnumerable<T>> LoadData<T, U>(string query, char queryType, U parameters, string connectionId = "StackDbConnection")
    {
        using IDbConnection connection = new SqlConnection(_config.GetConnectionString("StackDbConnection"));

        if (queryType == 'Q')
        {
            return await connection.QueryAsync<T>(query, parameters);
        }
        else
        {
            return await connection.QueryAsync<T>(query, parameters, commandType: CommandType.StoredProcedure);
        }
    }

    public async Task SaveData<T>(string storedProcedure, T parameters, string connectionId = "StackDbConnection")
    {
        using IDbConnection connection = new SqlConnection(_config.GetConnectionString(connectionId));

        await connection.ExecuteAsync(storedProcedure, parameters, commandType: CommandType.StoredProcedure);
    }
}
