﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UserEmail.Management.Service.Models;

namespace UserEmail.Management.Service.Service
{
    public interface IEmailService
    {
        void SendEmail(Message message);
    }
}
